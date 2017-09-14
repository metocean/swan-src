#!/bin/bash

echo -e

echo "----------------- Building SWAN -----------------" 
source /opt/intel/bin/iccvars.sh intel64
source /opt/intel/bin/ifortvars.sh intel64
source /opt/intel/bin/compilervars.sh intel64

INSTALL_DIR=/usr/local/bin
echo "SWAN install dir: $INSTALL_DIR"

# Building MPI and Serial versions (OMP not working for some reason)
for mode in mpi ser; do
    echo "Building $FTN version of SWAN in $mode mode"
    cd $SWAN_SRC/ftn_$FTN
    make clean
    (make $mode 2>&1) | tee build_$mode.log
    mv swan.exe $INSTALL_DIR/swan_$mode.exe
done

# Setting default binary and cleaning up
echo "Setting default SWAN binary: swan_$DEFAULT_MODE.exe --> swan.exe"
cd $INSTALL_DIR
ln -s swan_$DEFAULT_MODE.exe swan.exe
cd /home/metocean
rm -rf $SWAN_SRC

# set ulimit
echo 'ulimit -s unlimited' >> ~metocean/.bashrc

echo "Finished $0."