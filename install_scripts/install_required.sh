#!/bin/bash

set -e

# # Set up intel binaries (only if using intel compiler)
# source /opt/intel/bin/iccvars.sh intel64
# source /opt/intel/bin/ifortvars.sh intel64
# source /opt/intel/bin/compilervars.sh intel64
# # Set compilers and flags
# export FC=ifort
# export CC=icc
# export CXX=icpc

build_output=/home/metocean/build_output

###########
## mpich ##
###########
echo "Installing mpich..."
logdir=${build_output}/mpich
mkdir -p ${logdir}
wget http://www.mpich.org/static/downloads/$MPICH_VERSION/mpich-$MPICH_VERSION.tar.gz
tar zxvf mpich-$MPICH_VERSION.tar.gz
cd mpich-$MPICH_VERSION
./configure 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
ldconfig /usr/local/lib
cd ../

#######################################
## hdf5, static, no dap, no parallel ##
#######################################
echo "Installing hdf5..."
IFS=. read major minor micro <<EOF
${HDF5_VERSION}
EOF
logdir=${build_output}/hdf5
mkdir -p ${logdir}
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$major.$minor/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz
tar zxvf hdf5-$HDF5_VERSION.tar.gz
cd hdf5-$HDF5_VERSION
./configure --prefix=/usr/local --enable-fortran --enable-cxx --enable-hl --disable-dap --disable-shared 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
ldconfig /usr/local/lib
cd ../

##########################################
## netcdf4, static, no dap, no parallel ##
##########################################
echo "Installing netcdf4..."
logdir=${build_output}/netcdf4
mkdir -p ${logdir}
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-$NETCDF_VERSION.tar.gz
tar zxvf netcdf-$NETCDF_VERSION.tar.gz
cd netcdf-$NETCDF_VERSION
./configure --disable-dap --disable-shared --enable-static --disable-v2 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
nc-config --all 2>&1 | tee ${logdir}/nc-config.log
ldconfig /usr/local/lib
cd ../

#####################
## netcdf4-fortran ##
#####################
# it might need to set flags, it is breaking the SWAN compilation
echo "Installing netcdf4-fortran..."
logdir=${build_output}/netcdf4-fortran
mkdir -p ${logdir}
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz
tar zxvf netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz
cd netcdf-fortran-${NETCDF_FORTRAN_VERSION}
./configure --disable-dap --disable-shared --enable-static --disable-v2 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
nc-config --all 2>&1 | tee ${logdir}/nc-config.log
ldconfig /usr/local/lib
cd ../

echo "Finished $0."
