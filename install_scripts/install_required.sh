#!/bin/bash

# plain "set -e" doesn't work for pipes (e.g., errors in the "make | tee" command below could still go unnoticed)
set -e -x -o pipefail

# # Set up intel binaries
source /opt/intel/bin/iccvars.sh intel64
source /opt/intel/bin/ifortvars.sh intel64
source /opt/intel/bin/compilervars.sh intel64
# Set compilers and flags
export FC=ifort
export CC=icc
export CXX=icpc


build_output=/home/metocean/build_output

###########
## mpich ##
###########
echo "Installing mpich..."
logdir=${build_output}/mpich
mkdir -p ${logdir}
wget -nv http://www.mpich.org/static/downloads/$MPICH_VERSION/mpich-$MPICH_VERSION.tar.gz
tar zxf mpich-$MPICH_VERSION.tar.gz
cd mpich-$MPICH_VERSION
./configure --disable-cxx 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
ldconfig /usr/local/lib
cd ../

#######################################
## hdf5, static, no dap, no parallel ##
#######################################
echo "Installing hdf5..."
IFS=. read major minor micro <<< ${HDF5_VERSION}
logdir=${build_output}/hdf5
mkdir -p ${logdir}
wget -nv https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$major.$minor/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz
tar zxf hdf5-$HDF5_VERSION.tar.gz
cd hdf5-$HDF5_VERSION
./configure --prefix=/usr/local --enable-fortran --enable-hl --disable-dap --disable-shared 2>&1 | tee ${logdir}/configure.log
# needed to avoid 'catastrophic error: cannot open source file "bits/c++config.h"'
# export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/include/x86_64-linux-gnu/c++/8 &&\
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
wget -nv ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-$NETCDF_VERSION.tar.gz
tar zxf netcdf-$NETCDF_VERSION.tar.gz
cd netcdf-$NETCDF_VERSION
./configure --disable-dap --disable-shared --enable-static --disable-v2 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
nc-config --all 2>&1 | tee ${logdir}/nc-config.log
make check 2>&1 | tee ${logdir}/make_check.log
ldconfig /usr/local/lib
cd ../

#####################
## netcdf4-fortran ##
#####################
echo "Installing netcdf4-fortran..."
logdir=${build_output}/netcdf4-fortran
mkdir -p ${logdir}
wget -nv ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz
tar zxf netcdf-fortran-${NETCDF_FORTRAN_VERSION}.tar.gz
cd netcdf-fortran-${NETCDF_FORTRAN_VERSION}
./configure --disable-shared --enable-static 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
nc-config --all 2>&1 | tee ${logdir}/nc-config.log
ldconfig /usr/local/lib
cd ../

echo "Finished $0."
