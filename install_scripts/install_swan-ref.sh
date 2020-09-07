#!/bin/bash

echo -e

echo "----------------- Building SWAN REFERENCE SRC -----------------" 
INSTALL_DIR=/usr/local/bin/swan
echo "SWAN install dir: $INSTALL_DIR"
rm $SWAN_SRC/ftn_msl/macros.inc
ln -s $SWAN_SRC/ftn_msl/macros/gfortran_static_macros.inc $SWAN_SRC/ftn_msl/macros.inc
rm $SWAN_SRC/ftn_stock/macros.inc
ln -s $SWAN_SRC/ftn_msl/macros/gfortran_static_macros.inc $SWAN_SRC/ftn_stock/macros.inc

# Building MPI and Serial versions (OMP not working for some reason)
for mode in omp ser; do
    echo "Building ${FTNREF} version of SWAN in $mode mode"
    cd $SWAN_SRC/ftn_${FTNREF}
    make clobber
    patch -p0 < netcdf_multiple_compute3.patch
    (make $mode 2>&1) | tee build_$mode.log
    mv swan.exe $INSTALL_DIR/swan_$mode-ref.exe
done

# Setting default binary and cleaning up
echo "Setting default reference SWAN binary: swan_$DEFAULT_MODE-ref.exe --> swan-ref.exe"
cd /usr/local/bin
ln -s swan/swan_$DEFAULT_MODE-ref.exe ./swan-ref.exe
cd /home/metocean
rm -rf $SWAN_SRC

# set ulimit
echo 'ulimit -s unlimited' >> ~metocean/.bashrc

echo "Finished $0."