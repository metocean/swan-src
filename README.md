# swan-src
## SWAN Model Source Code
http://swanmodel.sourceforge.net/
- [ftn_stock](https://github.com/metocean/swan-src/tree/master/swan_src/ftn_stock): original stock code with patch applied and macros.inc defined
- [ftn_msl](https://github.com/metocean/swan-src/tree/master/swan_src/ftn_msl): code with MSL modifications

# Dockerfiles

1. ## Dockerfile:
### Args:
- mpich_version
- hdf5_version
- netcdf_version
- netcdf_fortran_version

### Tasks:
- Remove any existing installs of `mpich`, `hdf5` and `netcdf`
- Download stripped ifort (2013) from specified server
- Source intel binaries and set compilers
- Download and install `mpich` ([Version 3.2](http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz))
- Download and install `hdf5` ([Version 1.10.1](https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.1/src/hdf5-1.10.1.tar.gz))
- Download and install `netcdf4` ([Version 4.4.1](ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.4.1.tar.gz))
- Download and install `netcdf4-fortran` ([Version 4.4.4](ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.4.tar.gz))

2. ## Dockerfile-model
### Args:
- ftn (msl | stock)
- default_mode (mpi | ser)

### Tasks:
- Copy source code from /source/swan-src/swan_src/ftn_$FTN in source
- Build static SWAN binary with netcdf4 support
- Move SWAN binary into /usr/local/bin/swan.exe
- Copy entrypoint script into /tmp/install_scripts/entrypoint.sh