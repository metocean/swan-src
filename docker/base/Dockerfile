FROM metocean/ops-bare
MAINTAINER Rafael Guedes <r.guedes@metocean.co.nz>

# Remove some pre-installed libraries and install others
RUN yum -y remove mpich* hdf5* netcdf* &&\
	yum -y install man make gcc-c++ glibc-static zlib-static zlib-devel &&\
    yum clean all

# Copy keys to root for github access
RUN ln -sf /home/metocean/.ssh /root/

# Download ifort from server
ADD download_intel.sh /tmp/
RUN cd /tmp && sh download_intel.sh

# Install model requirements
ADD install_required.sh /tmp/
RUN cd /tmp && sh install_required.sh &&\
	rm -rf /tmp/*