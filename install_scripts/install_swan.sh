#!/bin/bash

echo -e

echo "----------------- Building SWAN -----------------" 
INSTALL_DIR=/usr/local/bin/swan
mkdir $INSTALL_DIR
echo "SWAN install dir: $INSTALL_DIR"
rm $SWAN_SRC/ftn_$FTN/macros.inc
ln -s $SWAN_SRC/ftn_$FTN/macros/gfortran_static_macros.inc $SWAN_SRC/ftn_$FTN/macros.inc

# Building MPI and Serial versions (OMP not working for some reason)
for mode in omp ser; do
    echo "Building $FTN version of SWAN in $mode mode"
    cd $SWAN_SRC/ftn_$FTN
    make clobber
    (make $mode 2>&1) | tee build_$mode.log
    mv swan.exe $INSTALL_DIR/swan_$mode.exe
    if [ $mode == 'omp' ]; then
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