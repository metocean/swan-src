FROM metocean/ifort:v19-python_3.7-buster
FROM python:3.7-slim-buster
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
# install gfortran (or pgi) if not using intel (needed here?)
RUN apt install -y build-essential manpages-dev zlib1g zlib1g-dev m4 &&\
    # apt install -y gfortran &&\ 
    apt -y clean

# Needed to avoid some missing c++ header files issues like 'catastrophic error: cannot open source file "bits/c++config.h"'
RUN apt-get install -y gcc-multilib g++-multilib

# # Needed for Intel .sh scripts  (probably can remove)
# RUN apt-get install -y man

# # needed for some script called from compilervars.sh for Intel's MPI (probably can remove) (which we don't actually use since we build MPICH)
# RUN apt-get install -y libfabric1

# Handy for debugging
RUN apt-get install less

ADD install_scripts/install_required.sh /tmp/
RUN cd /tmp && ./install_required.sh &&\
    rm -rf /tmp/*

CMD ["/bin/bash"]