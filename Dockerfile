FROM metocean/ifort
FROM metocean/ops-bare
MAINTAINER Rafael Guedes <r.guedes@metocean.co.nz>

ARG mpich_version
ARG hdf5_version
ARG netcdf_version
ARG netcdf_fortran_version

# copy built intel compilers from previous stage into new docker stage
COPY --from=0 /opt/intel /opt/intel

# Get rid of password need
RUN echo /etc/sudoers >> "metocean   ALL = NOPASSWD: ALL"

# Set required environment variables
ENV MPICH_VERSION=$mpich_version
ENV HDF5_VERSION=$hdf5_version
ENV NETCDF_VERSION=$netcdf_version
ENV NETCDF_FORTRAN_VERSION=$netcdf_fortran_version

# Remove some pre-installed libraries and install others
RUN yum -y remove mpich* hdf5* netcdf* &&\
	yum -y install man make gcc-c++ glibc-static zlib-static zlib-devel m4 &&\
    yum clean all

# Copy keys to root for github access
RUN ln -sf /home/metocean/.ssh /root/

# Download ifort from server
# ADD install_scripts/download_intel.sh /tmp/
# RUN cd /tmp && sh download_intel.sh

# Install model requirements
ADD install_scripts/install_required.sh /tmp/
RUN cd /tmp && sh install_required.sh &&\
	rm -rf /tmp/*