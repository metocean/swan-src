FROM metocean/ops-base

MAINTAINER Rafael Guedes <r.guedes@metocean.co.nz>

USER root

# Install extra packages -------------------------
RUN yum -y install tmux glibc-static mpich python-psutil && \
    yum -y update && yum clean all &&\
    rm -rf /tmp/*

# Get SWAN repo with source code
RUN echo "-----------------Install SWAN-----------------" &&\
    git clone git@github.com:metocean/swan $REPOS/swan &&\
    ln -s $REPOS/swan/swan $VIRTUAL_ENV/lib/python2.7/site-packages/ &&\
    chown metocean:metocean -R $REPOS/swan

# Update MSL repos
RUN echo "-----------------Update MSL repos"-----------------"" &&\
    cd /$REPOS/pymo &&\
    git pull &&\
    cd /$REPOS/msl_actions &&\
    git pull

# static build: add netCDF and MPICH packages; sources:
# ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.3.1.tar.gz
# ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.2.tar.gz
# http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz
ADD packages/* /home/metocean/
RUN chown metocean:metocean -R ~metocean/*

USER metocean

# Replace macros
RUN ln -sf $REPOS/swan/src/macros/ifort_static_macros.inc \
           $REPOS/swan/src/macros.inc

# Export mpich path
RUN echo 'export PATH=$PATH:/sbin:/bin:/usr/sbin:/usr/bin:/usr/lib64/mpich/bin/' >> ~metocean/.bashrc

# source ifortvars.sh if available (e.g., if /opt/intel is mounted from the host
# or with --volumes-from another container)
RUN echo 'if [ -f /opt/intel/bin/ifortvars.sh ]; then . /opt/intel/bin/ifortvars.sh intel64; fi' >> ~metocean/.bashrc

# fake qsub and qstat so that swan_hc_new.py will work without TORQUE
ADD scripts/qsub  /usr/local/bin/
ADD scripts/qstat /usr/local/bin/

# shell script to build netCDF and MPICH
ADD scripts/swan_build_deps.sh /usr/local/bin/

# shell script to checkout MetOcean's SWAN source code and build it
ADD scripts/swan_build.sh /usr/local/bin/

# shell script to start multi-host MPI run
ADD scripts/mpi_docker.sh /usr/local/bin/

# Add pre-compiled swan binary to use when just running and not building the model
# Temporary until model build in Dockerfile is sorted out
# ADD ../bin/exe /bin/