#!/bin/bash

# echo commands, and exit on unset variables and (most) errors (incl. parts of pipes, e.g., "| tee")
set -euxo pipefail

# set up NVIDIA HPC SDK, copy-and-pasted from the official docs:
# https://docs.nvidia.com/hpc-sdk/hpc-sdk-install-guide/index.html#install-linux-end-usr-env-settings
NVARCH=`uname -s`_`uname -m`; export NVARCH
NVCOMPILERS=/opt/nvidia/hpc_sdk; export NVCOMPILERS
#MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/20.11/compilers/man; export MANPATH
PATH=$NVCOMPILERS/$NVARCH/20.11/compilers/bin:$PATH; export PATH


echo "----------------- Building SWAN -----------------"
INSTALL_DIR=/usr/local/bin/swan
mkdir -p $INSTALL_DIR
echo "SWAN install dir: $INSTALL_DIR"

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
