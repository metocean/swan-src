FROM metocean/ifort:v19-python_3.7-buster
FROM python:3.7-buster
LABEL maintainer "Henrique Rapizo <h.rapizo@metocean.co.nz>"

ARG mpich_version
ARG hdf5_version
ARG netcdf_version
ARG netcdf_fortran_version

# copy compiler(s)
COPY --from=0 /opt/intel /opt/intel

ARG USER_ID=1001
ARG GROUP_ID=1001
ARG USER_NAME=metocean

RUN apt -y update &&\
    apt install -y vim sudo &&\
    apt -y upgrade &&\
    apt -y clean

RUN adduser -u $USER_ID $USER_NAME --disabled-password &&\
    chmod 666 /etc/sudoers &&\
    echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers &&\
    chmod 440 /etc/sudoers &&\
    mkdir /config && chown $USER_ID:$GROUP_ID /config &&\
    mkdir /data && chown $USER_ID:$GROUP_ID /data && \
    mkdir /data_exchange && chown $USER_ID:$GROUP_ID /data_exchange &&\
    mkdir /hot && chown $USER_ID:$GROUP_ID /hot &&\
    mkdir /prod && chown $USER_ID:$GROUP_ID /prod &&\
    mkdir /scratch && chown $USER_ID:$GROUP_ID /scratch &&\
    mkdir /archive && chown $USER_ID:$GROUP_ID /archive &&\
    mkdir /logs && chown $USER_ID:$GROUP_ID /logs &&\
    mkdir /source && chown $USER_ID:$GROUP_ID /source &&\
    mkdir /flush && chown $USER_ID:$GROUP_ID /flush &&\
    mkdir /static && chown $USER_ID:$GROUP_ID /static

# Set required environment variables
ENV MPICH_VERSION=$mpich_version
ENV HDF5_VERSION=$hdf5_version
ENV NETCDF_VERSION=$netcdf_version
ENV NETCDF_FORTRAN_VERSION=$netcdf_fortran_version

# no pre-installed mpich/hdf5/netcdf so no need to remove as done previously
# install gfortran (or pgi) if not using intel
RUN apt install -y build-essential manpages-dev zlib1g zlib1g-dev m4 &&\
    apt install -y gfortran &&\
    apt -y clean

# Needed to avoid some missing c++ header files issues like 'catastrophic error: cannot open source file "bits/c++config.h"'
RUN apt-get install -y gcc-multilib g++-multilib

# Needed for Intel .sh scripts
RUN apt-get install -y man

# Handy for debugging
RUN apt-get install less

ENV FC=ifort
ENV CC=icc
ENV CXX=icpc
ENV build_output=/home/metocean/build_output

RUN cd /tmp &&\
    wget -nv http://www.mpich.org/static/downloads/$MPICH_VERSION/mpich-$MPICH_VERSION.tar.gz &&\
    tar zxf mpich-$MPICH_VERSION.tar.gz

SHELL ["/bin/bash", "-c"]

RUN logdir=${build_output}/mpich &&\
    mkdir -p ${logdir} &&\
    cd /tmp/mpich-$MPICH_VERSION &&\
    source /opt/intel/bin/compilervars.sh -arch intel64 &&\
    ./configure --disable-cxx 2>&1 | tee ${logdir}/configure.log

RUN logdir=${build_output}/mpich &&\
    mkdir -p ${logdir} &&\
    cd /tmp/mpich-$MPICH_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make 2>&1 | tee ${logdir}/make.log

RUN logdir=${build_output}/mpich &&\
    mkdir -p ${logdir} &&\
    cd /tmp/mpich-$MPICH_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make install 2>&1 | tee ${logdir}/make_install.log


RUN cd /tmp &&\
    IFS=. read major minor micro <<< ${HDF5_VERSION} &&\
    wget -nv https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$major.$minor/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz &&\
    tar zxf hdf5-$HDF5_VERSION.tar.gz

RUN logdir=${build_output}/hdf5 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/hdf5-$HDF5_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    # --enable-cxx
    ./configure --prefix=/usr/local --enable-fortran --enable-hl --disable-dap --disable-shared 2>&1 | tee ${logdir}/configure.log

RUN logdir=${build_output}/hdf5 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/hdf5-$HDF5_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    # needed to avoid 'catastrophic error: cannot open source file "bits/c++config.h"'
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/include/x86_64-linux-gnu/c++/8 &&\
    make 2>&1 | tee ${logdir}/make.log

RUN logdir=${build_output}/hdf5 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/hdf5-$HDF5_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make install 2>&1 | tee ${logdir}/make_install.log &&\
    ldconfig /usr/local/lib


RUN cd /tmp &&\
    wget -nv ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-$NETCDF_VERSION.tar.gz &&\
    tar zxf netcdf-$NETCDF_VERSION.tar.gz

RUN logdir=${build_output}/netcdf4 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-$NETCDF_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    ./configure --disable-dap --disable-shared --enable-static --disable-v2 2>&1 | tee ${logdir}/configure.log

RUN logdir=${build_output}/netcdf4 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-$NETCDF_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make 2>&1 | tee ${logdir}/make.log


RUN logdir=${build_output}/netcdf4 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-$NETCDF_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make install 2>&1 | tee ${logdir}/make_install.log


RUN logdir=${build_output}/netcdf4 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-$NETCDF_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    nc-config --all 2>&1 | tee ${logdir}/nc-config.log


RUN logdir=${build_output}/netcdf4 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-$NETCDF_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make check 2>&1 | tee ${logdir}/make_check.log


RUN logdir=${build_output}/netcdf4 &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-$NETCDF_VERSION &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    ldconfig /usr/local/lib


RUN cd /tmp &&\
    wget -nv ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz &&\
    tar zxvf netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz

RUN logdir=${build_output}/netcdf4-fortran &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-fortran-${NETCDF_FORTRAN_VERSION} &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    ./configure --disable-shared --enable-static 2>&1 | tee ${logdir}/configure.log

RUN logdir=${build_output}/netcdf4-fortran &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-fortran-${NETCDF_FORTRAN_VERSION} &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make 2>&1 | tee ${logdir}/make.log

RUN logdir=${build_output}/netcdf4-fortran &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-fortran-${NETCDF_FORTRAN_VERSION} &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    make install 2>&1 | tee ${logdir}/make_install.log

RUN logdir=${build_output}/netcdf4-fortran &&\
    mkdir -p ${logdir} &&\
    cd /tmp/netcdf-fortran-${NETCDF_FORTRAN_VERSION} &&\
    source /opt/intel/bin/compilervars.sh intel64 &&\
    nc-config --all 2>&1 | tee ${logdir}/nc-config.log &&\
    ldconfig /usr/local/lib


CMD ["/bin/bash"]