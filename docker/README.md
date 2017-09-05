## Building SWAN Docker

### base/Dockerfile (from ops-bare):
- Remove any existing installs of `mpich`, `hdf5` and `netcdf`
- Download stripped ifort (2013) from specified server
- Source intel binaries and set compilers
- Download and install `mpich` ([Version 3.2](http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz))
- Download and install `hdf5` ([Version 1.10.1](https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.1/src/hdf5-1.10.1.tar.gz))
- Download and install `netcdf4` ([Version 4.4.1](ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-${version}.tar.gz))

## Docker-compose
- `ifort` service sets up ifort docker
- `build` service provides full build environment ready to compile SWAN with ifort
