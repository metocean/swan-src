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

echo "Finished $0."
