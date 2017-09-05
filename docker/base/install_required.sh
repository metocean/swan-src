# History:
#   2016-01-16 - Merged from Tom Durrant and Alex Port scripts
#   2016-02-19 - To be called from dockerfile as root (sudo needs tty session)
#   2017-10-05 - Updated library versions, installing m4

set -e

# Set up intel binaries
source /opt/intel/bin/iccvars.sh intel64
source /opt/intel/bin/ifortvars.sh intel64
source /opt/intel/bin/compilervars.sh intel64

# Set compilers and flags
export FC=ifort
export CC=icc
export CXX=icpc

build_output=/home/metocean/build_output

##############################
## Download intel compilers ##
##############################

###########
## mpich ##
###########

echo "Installing mpich..."
logdir=${build_output}/mpich
mkdir -p ${logdir}
wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
tar zxvf mpich-3.2.tar.gz
cd mpich-3.2
./configure --with-device=ch3:nemesis:mxm 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
ldconfig /usr/local/lib
cd ../

#######################################
## hdf5, static, no dap, no parallel ##
#######################################

echo "Installing hdf5..."
logdir=${build_output}/hdf5
mkdir -p ${logdir}
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.1/src/hdf5-1.10.1.tar.gz
tar zxvf hdf5-1.10.1.tar.gz
cd hdf5-1.10.1
./configure --prefix=/usr/local --enable-fortran --enable-cxx --enable-hl --disable-dap --disable-shared 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
ldconfig /usr/local/lib
cd ../

########
## m4 ##
########

echo "Installing m4..."
logdir=${build_output}/m4
mkdir -p ${logdir}
wget ftp://ftp.gnu.org/gnu/m4/m4-1.4.10.tar.gz
tar zxvf m4-1.4.10.tar.gz
cd m4-1.4.10
./configure --prefix=/usr/local | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
ldconfig /usr/local/lib
cd ../

##########################################
## netcdf4, static, no dap, no parallel ##
##########################################

echo "Installing netcdf4..."
version=4.4.1
logdir=${build_output}/netcdf4
mkdir -p ${logdir}
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-${version}.tar.gz
tar zxvf netcdf-${version}.tar.gz
cd netcdf-${version}
./configure --disable-dap --disable-shared --enable-static --disable-v2 2>&1 | tee ${logdir}/configure.log
make 2>&1 | tee ${logdir}/make.log
make install 2>&1 | tee ${logdir}/make_install.log
nc-config --all 2>&1 | tee ${logdir}/nc-config.log
ldconfig /usr/local/lib
cd ../

echo "Finished $0."
