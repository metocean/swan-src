import os
import subprocess
import shutil
import pytest
import glob
from collections import OrderedDict
import logging
import datetime
import xarray as xr # issue lots of warnings

# from wavespectra import read_swan #TODO implement tests using wavespectra

logging.basicConfig(level=logging.DEBUG)

errors = []

class TestOMP(object):
    """Compile new swan-src code and compare to reference Delft version """

    @classmethod
    def setup_test(self, models):
        self.logger = logging

        self.BASEDIR = '/home/metocean'
        self.MPIDIR  = os.path.join(self.BASEDIR, 'swan-mpi')
        self.OMPDIR  = os.path.join(self.BASEDIR, 'swan-omp')        
        self.TARBALL = os.path.join(self.BASEDIR, 'tinyapp.tar.gz')
        self.CTLDIR  = os.path.join(self.BASEDIR, 'tinyapp')
        self.BINDIR  = os.path.join('/usr/local/bin')
        self.logger.info('  Uncompressing test files\n')
        os.system('tar -xzvf {} -C {}'.format(self.TARBALL, self.BASEDIR))

    def run_mpi(self):
        """run new src"""
        self.logger.info('  Running model in mpi (reference): see run log in {}\n'.format(self.MPIDIR+'/mpi.log'))

        os.chdir(self.BINDIR)
        os.system('unlink ./swan.exe') # unlink swan.exe
        os.system('ln -s swan/swan_mpi.exe ./swan.exe') # set swan.exe to mpi mode

        if not os.path.exists(self.MPIDIR): shutil.copytree(self.CTLDIR, self.MPIDIR)
        os.chdir(self.MPIDIR)
        os.system('rm -rf out/*')
        jobstr = self.BINDIR+'/mpiexec -n 2 '+self.BINDIR+'/swan.exe par.20180513_00z_4120.swn &> mpi.log'
        os.system(jobstr)
        
        self.logger.info('  obtaining running time for mpi simmulation')
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
        jobstr = self.BINDIR+'/swanrun -input par.20180513_00z_4120.swn -omp 2 &> omp.log'
        os.system(jobstr)

        self.logger.info('  obtaining running time for omp simmulation')
        fid = open('par.20180513_00z_4120.prt', 'r')
        timerow = fid.read().splitlines()[2] # row in PRINT file with start time
        timesepi = timerow.find(".")
        datei, timei = timerow[timesepi-8:timesepi], timerow[timesepi+1:timesepi+7]
        tstart = datetime.datetime.strptime(datei+timei, '%Y%m%d%H%M%S')
        tend = datetime.datetime(1970,1,1,0,0)+datetime.timedelta(seconds=os.path.getmtime('par.20180513_00z_4120.prt'))
        runtime = tend-tstart

        self.logger.info(' Running time for omp is: {} minutes \n'.format(runtime.seconds/60.))

    def test_grid(self, models):
        # first test runs both models
        self.setup_test(models)
        self.run_mpi()
        self.run_omp()

        ncmpi = glob.glob(self.MPIDIR+'/out/*.nc')[0]
        dsmpi = xr.open_dataset(ncmpi)
        ncomp = glob.glob(self.OMPDIR+'/out/*.nc')[0]
        dsomp = xr.open_dataset(ncomp)        
        
        varnames = ['hs','tm01','tm02','xwnd','ywnd','hswe','tps'] # maybe use all var in ds?
        self.logger.info(' Performing grid test for {}: \n'.format([dispvar.title() for dispvar in varnames]))
        for varname in varnames:
            # print('...checking grid for: {}'.format(varname.title()))

            parmpi = dsmpi[varname]; paromp = dsomp[varname]
            rdiff = (parmpi - paromp)/parmpi
            if abs(rdiff.max()) > 0.01:
                errors.append("error: Maximum Relative {} difference = {:g} %".format(varname.title(), abs(rdiff.max().values)*100))
                self.logger.info(' {} failed :( \n'.format(varname.title()))
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