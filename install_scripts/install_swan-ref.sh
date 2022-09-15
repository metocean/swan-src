#!/bin/bash

# This script needs to be source'd before calling any Intel compilers
source /opt/intel/oneapi/setvars.sh intel64

# plain "set -e" doesn't work for pipes (e.g., errors in the "make | tee" command below could still go unnoticed)
# setting -e before compilervars.sh has sometimes caused problems
set -e -u -x -o pipefail

echo "----------------- Building SWAN REFERENCE SRC -----------------" 
INSTALL_DIR=/usr/local/bin/swan
echo "SWAN install dir: $INSTALL_DIR"

# Building MPI and Serial versions (OMP not working for some reason)
for mode in mpi omp; do
    printf "\nBuilding ${FTNREF} version of SWAN in $mode mode\n"
    cd $SWAN_SRC/ftn_${FTNREF}
    make clobber
    if [ $mode == 'mpi' ]; then
        echo "Applying patch"
        patch -p0 < netcdf_multiple_compute3.patch
    fi
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
