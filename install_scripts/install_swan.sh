#!/bin/bash

# This script needs to be source'd before calling any Intel compilers

# plain "set -e" doesn't work for pipes (e.g., errors in the "make | tee" command below could still go unnoticed)
# setting -e before compilervars.sh has sometimes caused problems
set -e -u -x -o pipefail

echo "----------------- Building SWAN -----------------"
INSTALL_DIR=/usr/local/bin/swan
mkdir $INSTALL_DIR
echo "SWAN install dir: $INSTALL_DIR"

unlink $SWAN_SRC/ftn_$FTN/macros.inc
ln -s $SWAN_SRC/ftn_msl/macros/nvidia_static_macros.inc $SWAN_SRC/ftn_$FTN/macros.inc

# Building MPI and Serial versions
for mode in mpi omp ser; do
    echo "Building $FTN version of SWAN in $mode mode"
    cd $SWAN_SRC/ftn_$FTN
    make clobber
    (make $mode 2>&1) | tee build_$mode.log
    mv swan.exe $INSTALL_DIR/swan_$mode.exe
    if [ $mode == 'mpi' ]; then
        mv hcat.exe $INSTALL_DIR/
        chmod 777 swanrun && mv swanrun $INSTALL_DIR/
    fi
done

# Setting default binary and cleaning up
echo "Setting default SWAN binary: swan_$DEFAULT_MODE.exe --> swan.exe"
cd /usr/local/bin
ln -s swan/swan_$DEFAULT_MODE.exe ./swan.exe
ln -s swan/hcat.exe ./hcat.exe
ln -s swan/swanrun ./swanrun
cd /home/metocean
rm -rf $SWAN_SRC

# set ulimit
echo 'ulimit -s unlimited' >> ~metocean/.bashrc

echo "Finished $0."
