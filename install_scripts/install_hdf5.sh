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


echo "Finished $0."
