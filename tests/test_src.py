import logging
import os
import sh
import shutil
import pytest
import glob
from collections import OrderedDict
from datetime import datetime
import xarray as xr # issue lots of warnings

# from wavespectra import read_swan #TODO implement tests using wavespectra

errors = []

class TestSwanSrc(object):
    """Compile new swan-src code and compare to reference Delft version """

    @classmethod
    def setup_test(self, models):
        self.logger = logging

        # model versions (parsed from command line)
        self.ref = models[0]
        self.new = models[1]


        self.BASEDIR = '/home/metocean'
        self.NEWDIR  = os.path.join(self.BASEDIR, 'swan-new')
        self.REFDIR  = os.path.join(self.BASEDIR, 'swan-ref')
        self.TARBALL = os.path.join(self.BASEDIR, 'tinyapp.tar.gz')
        self.CTLDIR  = os.path.join(self.BASEDIR, 'tinyapp')
        self.BINDIR  = os.path.join('/usr/local/bin')
        self.logger.info('  Uncompressing test files\n')
        os.system('tar -xzvf {} -C {}'.format(self.TARBALL, self.BASEDIR))

    def run_ref(self):
        """run reference src"""
        self.logger.info('  Running reference model: {}\n see run log in {}\n'.format(self.ref,self.REFDIR+'/ref.log'))

        if not os.path.exists(self.REFDIR): shutil.copytree(self.CTLDIR, self.REFDIR)
        os.chdir(self.REFDIR)
        sh.touch("machinefile")
        os.system('rm -rf out/*')
        if self.ref == self.new:
            os.system('unlink '+self.BINDIR+'/swan.exe && ln -s '+self.BINDIR+'/swan/swan_mpi-ref.exe '+self.BINDIR+'/swan.exe')
            with open("./ref.log", "w") as h:
                sh.swanrun('-input','par.20180513_00z_'+self.ref+'.swn','-mpi','2',_out=h)
            os.system('unlink '+self.BINDIR+'/swan.exe && ln -s '+self.BINDIR+'/swan/swan_mpi.exe '+self.BINDIR+'/swan.exe')
        else:
            with open("./ref.log", "w") as h:
                sh.mpiexec('-n','2',self.BINDIR+'/swan-ref.exe','par.20180513_00z_'+self.ref+'.swn',_out=h)            
       
    def run_new(self):
        """run new src"""
        self.logger.info('  Running model to be tested: {}\n see run log in {}\n'.format(self.new,self.NEWDIR+'/new.log'))
        if not os.path.exists(self.NEWDIR): shutil.copytree(self.CTLDIR, self.NEWDIR)
        os.chdir(self.NEWDIR)
        sh.touch("machinefile")
        os.system('rm -rf out/*')
        with open("./new.log", "w") as h:
            sh.mpiexec('-n','2',self.BINDIR+'/swan.exe','par.20180513_00z_'+self.new+'.swn',_out=h)

    def test_grid(self, models):
        # first test runs both models
        self.setup_test(models)
        self.run_ref()
        self.run_new()

        ncref = glob.glob(self.REFDIR+'/out/*.nc')[0]
        dsref = xr.open_dataset(ncref)
        ncnew = glob.glob(self.NEWDIR+'/out/*.nc')[0]
        dsnew = xr.open_dataset(ncnew)
        # check if rename is necessary

        if self.ref != self.new:
            vardict=[(list(dsref.var())[i], list(dsnew.var())[i]) for i in range(len(dsref.var()))]
            var_mapping = OrderedDict((vardict))
            dimdict=[(list(dsref.coords)[i], list(dsnew.coords)[i]) for i in range(len(dsref.coords))]
            dim_mapping = OrderedDict((dimdict))
            
            dsref = dsref.rename(var_mapping)
            dsref = dsref.rename(dim_mapping)
        
        varnames = ['hs','tm01','tm02','xwnd','ywnd','hswe','tps'] # maybe use all var in ds?
        self.logger.info(' Performing grid test for {}: \n'.format([dispvar.title() for dispvar in varnames]))
        for varname in varnames:
            # self.logger.info('...checking grid for: {}'.format(varname.title()))

            parref = dsref[varname]; parnew = dsnew[varname]
            rdiff = (parref - parnew)/parref
            if abs(rdiff.max()) > 0.05:
                errors.append("error: Maximum Relative {} difference = {:g} %".format(varname.title(), abs(rdiff.max().values)*100))
                self.logger.error(' {} failed :( \n'.format(varname.title()))
            else:
                self.logger.info(' {} passed :) \n'.format(varname.title()))

        # assert no error message has been registered, else print messages
        assert not errors, "grid test - following errors occured:\n{}".format("\n".join(errors))    

    # def test_param(self):        
    #     hsref = read_swan(self.REFDIR+'/out/pt01.spec').spec.hs().values
    #     hsnew = read_swan(self.NEWDIR+'/out/pt01.spec').spec.hs().values
    #     tmref = read_swan(self.REFDIR+'/out/pt01.spec').spec.tm01().values
    #     tmnew = read_swan(self.NEWDIR+'/out/pt01.spec').spec.tm01().values
    #     dpref = read_swan(self.REFDIR+'/out/pt01.spec').spec.dpm().values
    #     dpnew = read_swan(self.NEWDIR+'/out/pt01.spec').spec.dpm().values
        
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
