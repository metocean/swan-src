#!/bin/bash

echo -e

echo "----------------- Building SWAN REFERENCE SRC -----------------" 
source /opt/intel/bin/iccvars.sh intel64
source /opt/intel/bin/ifortvars.sh intel64
source /opt/intel/bin/compilervars.sh intel64

INSTALL_DIR=/usr/local/bin/swan
echo "SWAN install dir: $INSTALL_DIR"

# Building MPI and Serial versions (OMP not working for some reason)
for mode in mpi ser; do
    echo "Building ${FTNREF} version of SWAN in $mode mode"
    cd $SWAN_SRC/ftn_${FTNREF}
    make clobber
    patch -p0 < netcdf_multiple_compute3.patch
    (make $mode 2>&1) | tee build_$mode.log
    mv swan.exe $INSTALL_DIR/swan_$mode-ref.exe
done
if [ $FTNREF = "stock" ]; then 
    cp swanrun $INSTALL_DIR/
    chmod +rx $INSTALL_DIR/swanrun
fi

# Setting default binary and cleaning up
echo "Setting default SWAN binary: swan_$DEFAULT_MODE.exe --> swan.exe"
cd /usr/local/bin
ln -s swan/swan_$DEFAULT_MODE-ref.exe ./swan-ref.exe
ln -s swan/swanrun ./swanrun
cd /home/metocean
rm -rf $SWAN_SRC

# set ulimit
echo 'ulimit -s unlimited' >> ~metocean/.bashrc

echo "Finished $0."