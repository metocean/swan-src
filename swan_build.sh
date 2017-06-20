#!/bin/bash
me=`basename $0`

echo -e "\n$(date): $me started\n"

# There used to be some code here to make sure we don't store plain-text
# passwords for svn, but since the swan repo is now on github that's no longer
# needed. Backed up on the wiki just in case:
# https://wiki.metocean.co.nz/display/~aport/svn+password+options

# ----------------------------------------- get or update MetOcean's SWAN source
# ------------------------------------------------------------------------------
if [[ $# -eq 1 ]]; then
    ver=$1
else
    echo "What version do you want to compile? [msl | stock]"
    exit 1
fi

if [ -d /source/swan-src ]; then
    echo "Updating SWAN-SRC repo"
    cd /source/swan-src
    git checkout master
    git pull
else
    echo "Cloning SWAN-SRC repo"
    cd /source
    git clone git@github.com:metocean/swan-src.git
fi
git checkout 4010A
cd /source/swan-src/swan_src/ftn_${ver}

# ---------------------------------------------------------- ifort configuration
# ------------------------------------------------------------------------------
. /opt/intel/bin/ifortvars.sh intel64

# for some reason mpif90 does not automatically end up on the search path; and
# we don't want to use the intel mpiexec either, so prepending this after
# sourcing ifortvars.sh is good anyway :)
export PATH=/usr/lib64/mpich/bin/:$PATH

# ------------------------------------------------------------------------ build
# ------------------------------------------------------------------------------
(make mpi 2>&1) | tee build.log

echo "make finished, output save in build.log"

echo -e "\n$(date): $me finished\n"
