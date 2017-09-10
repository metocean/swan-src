#!/bin/bash

echo -e

echo "----------------- Building SWAN -----------------" 
source /opt/intel/bin/iccvars.sh intel64
source /opt/intel/bin/ifortvars.sh intel64
source /opt/intel/bin/compilervars.sh intel64

# for some reason mpif90 does not automatically end up on the search path; and
# we don't want to use the intel mpiexec either, so prepending this after
# sourcing ifortvars.sh is good anyway :)
export PATH=/usr/lib64/mpich/bin/:$PATH

# Build model
echo "Building $FTN version of SWAN in  $MODE mode"
cd $SWAN_SRC/ftn_$FTN
make clean
(make $MODE 2>&1) | tee build.log

# Move binary and clean up
echo "Moving SWAN binary to /usr/local/bin"
mv swan.exe /usr/local/bin/
cd /home/metocean
rm -rf $SWAN_SRC

# set ulimit
echo 'ulimit -s unlimited' >> ~metocean/.bashrc

echo "Finished $0."