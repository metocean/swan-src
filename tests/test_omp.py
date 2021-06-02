import os
import sh
import shutil
import pytest
import glob
from collections import OrderedDict
import logging
import datetime
import xarray as xr # issue lots of warnings

# from wavespectra import read_swan #TODO implement tests using wavespectra

errors = []

class TestOMP(object):
    """Compile new swan-src code and compare to reference Delft version """

    @classmethod
    def setup_test(self, imp, ncores):
        self.logger = logging

        imp = imp

        self.logger.info(' Running OMP vs MPI test for SWAN implementation '+imp+'\n')

        self.BASEDIR = '/home/metocean'
        self.MPIDIR  = os.path.join(self.BASEDIR, imp+'-mpi-'+'ncores-'+ncores)
        self.OMPDIR  = os.path.join(self.BASEDIR, imp+'-omp-'+'ncores-'+ncores)
        self.TARBALL = os.path.join(self.BASEDIR, imp+'.tar.gz')
        self.CTLDIR  = os.path.join(self.BASEDIR, imp)
        self.BINDIR  = os.path.join('/usr/local/bin')
        self.logger.info('  Uncompressing test files\n')
        self.ncores  = ncores
        os.system('tar -xzvf {} -C {}'.format(self.TARBALL, self.BASEDIR))
        self.logger.basicConfig(filename=os.path.join(self.BASEDIR, imp+'-mpi-'+'ncores-'+ncores,'swn_logger.log'),level=logging.DEBUG)

    def run_mpi(self):
        """run new src"""
        self.logger.info(' Running model in mpi (reference): see run log in {}\n'.format(self.MPIDIR+'/mpi.log'))

        os.chdir(self.BINDIR)
        os.system('unlink ./swan.exe') # unlink swan.exe
        os.system('ln -s swan/swan_mpi.exe ./swan.exe') # set swan.exe to mpi mode

        if not os.path.exists(self.MPIDIR): shutil.copytree(self.CTLDIR, self.MPIDIR)
        os.chdir(self.MPIDIR)
        os.system('rm -rf out/*')

        swnfile = glob.glob('*.swn')[0]
        with open("./mpi.log", "w") as h:
            sh.mpiexec('-n',self.ncores,self.BINDIR+'/swan.exe',swnfile,_out=h)

        self.logger.info('  obtaining running time for mpi simmulation\n')
        fid = open('PRINT-001', 'r')
        timerow = fid.read().splitlines()[2] # row in PRINT file with start time
        timesepi = timerow.find(".")
        datei, timei = timerow[timesepi-8:timesepi], timerow[timesepi+1:timesepi+7]
        tstart = datetime.datetime.strptime(datei+timei, '%Y%m%d%H%M%S')
        tend = datetime.datetime(1970,1,1,0,0)+datetime.timedelta(seconds=os.path.getmtime('PRINT-001'))
        runtime = tend-tstart

        self.logger.info(' Running time for mpi is: {} minutes \n'.format(runtime.seconds/60.))

    def run_omp(self):
        """run new src"""
        self.logger.info('  Running model with openmp (tested): see run log in {}\n'.format(self.OMPDIR+'/openmp.log'))

        os.chdir(self.BINDIR)
        os.system('unlink ./swan.exe') # unlink swan.exe
        os.system('ln -s swan/swan_omp.exe ./swan.exe') # link swan.exe to omp mode

        if not os.path.exists(self.OMPDIR): shutil.copytree(self.CTLDIR, self.OMPDIR)
        os.chdir(self.OMPDIR)
        os.system('rm -rf out/*')

        swnfile = glob.glob('*.swn')[0]
        with open("./omp.log", "w") as h:
            sh.swanrun('-input',swnfile,'-omp',self.ncores,_out=h)

        self.logger.info('  obtaining running time for omp simmulation\n')
        fid = open(swnfile.split('.swn')[0]+'.prt', 'r')
        timerow = fid.read().splitlines()[2] # row in PRINT file with start time
        timesepi = timerow.find(".")
        datei, timei = timerow[timesepi-8:timesepi], timerow[timesepi+1:timesepi+7]
        tstart = datetime.datetime.strptime(datei+timei, '%Y%m%d%H%M%S')
        tend = datetime.datetime(1970,1,1,0,0)+datetime.timedelta(seconds=os.path.getmtime(swnfile.split('.swn')[0]+'.prt'))
        runtime = tend-tstart

        self.logger.info(' Running time for omp is: {} minutes \n'.format(runtime.seconds/60.))

    def test_grid(self, imp, ncores):
        self.setup_test(imp, ncores)
        self.run_mpi()
        self.run_omp()

        ncmpi = glob.glob(self.MPIDIR+'/out/*.nc')[0]
        dsmpi = xr.open_dataset(ncmpi)
        ncomp = glob.glob(self.OMPDIR+'/out/*.nc')[0]
        dsomp = xr.open_dataset(ncomp)
        
        varnames = ['hs','tm01','tm02','xwnd','ywnd','hswe','tps'] # maybe use all var in ds?
        self.logger.info(' Performing grid test for {}: \n'.format([dispvar.title() for dispvar in varnames]))
        for varname in varnames:
            # self.logger.info('...checking grid for: {}'.format(varname.title()))

            parmpi = dsmpi[varname]; paromp = dsomp[varname]
            rdiff = (parmpi - paromp)/parmpi
            if abs(rdiff.max()) > 0.01:
                errors.append("error: Maximum Relative {} difference = {:g} %".format(varname.title(), abs(rdiff.max().values)*100))
                self.logger.error(' {} failed :( \n'.format(varname.title()))
            else:
                self.logger.info(' {} passed :) \n'.format(varname.title()))

        # assert no error message has been registered, else print messages
        assert not errors, "grid test - following errors occured:\n{}".format("\n".join(errors))    

    # def test_param(self):        
    #     hsref = read_swan(self.MPIDIR+'/out/pt01.spec').spec.hs().values
    #     hsnew = read_swan(self.OMPDIR+'/out/pt01.spec').spec.hs().values
    #     tmref = read_swan(self.MPIDIR+'/out/pt01.spec').spec.tm01().values
    #     tmnew = read_swan(self.OMPDIR+'/out/pt01.spec').spec.tm01().values
    #     dpref = read_swan(self.MPIDIR+'/out/pt01.spec').spec.dpm().values
    #     dpnew = read_swan(self.OMPDIR+'/out/pt01.spec').spec.dpm().values
        
    #     ratio_hs = (hsref-hsnew)/hsref
    #     ratio_tm = (tmref-tmnew)/tmref
    #     ratio_dp = (dpref-dpnew)/dpref

    #     if ratio_hs.max() > 0.05:
    #         errors.append("error in hs, rdif={}".format(ratio_hs))
    #     if ratio_tm.max() > 0.05:
    #         errors.append("error in tm, rdif={}".format(ratio_tm))
    #     if ratio_dp.max() > 0.05:
    #         errors.append("error in dp, rdif={}".format(ratio_dp))

    #     # assert no error message has been registered, else print messages
    #     assert not errors, "errors occured:\n{}".format("\n".join(errors))        

    # def test_spec(self):
    #     "test spectral output"