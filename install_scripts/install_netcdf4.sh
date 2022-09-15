#!/bin/bash

# This script needs to be source'd before calling any Intel compilers
# source /opt/intel/bin/compilervars.sh intel64
source /opt/intel/oneapi/setvars.sh intel64

# plain "set -e" doesn't work for pipes (e.g., errors in the "make | tee" command below could still go unnoticed)
# setting -e before compilervars.sh has sometimes caused problems
set -e -x -o pipefail

# Set compilers and flags
export FC=ifort
export CC=icc
export CXX=icpc

build_output=/home/metocean/build_output

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