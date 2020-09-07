# FROM metocean/ifort:2018
FROM python:3.8.5-buster
LABEL maintainer "Henrique Rapizo <h.rapizo@metocean.co.nz>"

# ARG mpich_version
# ARG hdf5_version
# ARG netcdf_version
# ARG netcdf_fortran_version

# # copy intel compiler from ifort image
# COPY --from=0 /opt/intel /opt/intel

# installed a few libraries
RUN apt-get update && apt-get -y install man sudo vim git &&\
    apt-get -y install mpich netcdf-bin libnetcdf-dev libnetcdff-dev nco &&\
	apt-get install -f && apt-get -y autoremove && apt-get autoclean

# Add metocean user
RUN useradd -ms /bin/bash metocean
# Get rid of password need
RUN echo /etc/sudoers >> "metocean   ALL = NOPASSWD: ALL"

# Set permissions
RUN chmod 666 /etc/sudoers &&\
    echo "metocean ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers &&\
    chmod 440 /etc/sudoers &&\
    mkdir /config && chown metocean:metocean /config &&\
    mkdir /data && chown metocean:metocean /data && \
    mkdir /data_exchange && chown metocean:metocean /data_exchange &&\
    mkdir /hot && chown metocean:metocean /hot &&\
    mkdir /prod && chown metocean:metocean /prod &&\
    mkdir /system && chown metocean:metocean /system &&\
    mkdir /scratch && chown metocean:metocean /scratch &&\
    mkdir /archive && chown metocean:metocean /archive &&\
    mkdir /logs && chown metocean:metocean /logs &&\
    mkdir /source && chown metocean:metocean /source &&\
    mkdir /static && chown metocean:metocean /static

# # Install model requirements
# ADD install_scripts/install_required.sh /tmp/
# RUN cd /tmp && sh install_required.sh &&\
# 	rm -rf /tmp/*

# Get rid of password need
RUN echo /etc/sudoers >> "metocean   ALL = NOPASSWD: ALL"

CMD ["/bin/bash"]