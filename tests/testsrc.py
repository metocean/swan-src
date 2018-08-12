import os
import subprocess
import shutil
import pytest
from datetime import datetime
from nco import Nco

from wavespectra import read_swan
import xarray as xr

errors = []

class TestSwanSrc(object):
    """Compile msl swan-src code and compare to original Delft version """

    @classmethod
    def set_dirs(self):
        # set directories
        self.BASEDIR = '/home/metocean'
        self.MSLDIR  = os.path.join(self.BASEDIR, 'swan-msl')
        self.ORIDIR  = os.path.join(self.BASEDIR, 'swan-ori')
        self.TARBALL = os.path.join(self.BASEDIR, 'tinyapp.tar.gz')
        self.CTLDIR  = os.path.join(self.BASEDIR, 'tinyapp')
        os.system('tar -xzvf {} -C {}'.format(self.TARBALL, self.BASEDIR))

    def run_ori(self):
        """run original src"""
        if not os.path.exists(self.ORIDIR): shutil.copytree(self.CTLDIR, self.ORIDIR)
        os.chdir(self.ORIDIR)
        os.system('rm -rf out/*')
        jobstr = 'mpiexec -n 2 swan-ori.exe par.20180513_00z.swn &> ori.log'
        os.system(jobstr)

    def run_msl(self):
        """run msl src"""
        if not os.path.exists(self.MSLDIR): shutil.copytree(self.CTLDIR, self.MSLDIR)
        os.chdir(self.MSLDIR)
        os.system('rm -rf out/*')
        jobstr = 'mpiexec -n 2 swan.exe par.20180513_00z.swn &> msl.log'
        os.system(jobstr)

    def test_grid(self):

        # first test runs both models
        self.set_dirs()
        self.run_ori()
        self.run_msl()

        dsori = xr.open_dataset(self.ORIDIR+'/out/par.20180513_00z.nc')
        dsmsl = xr.open_dataset(self.MSLDIR+'/out/par.20180513_00z.nc')

        varnames = ['hs','tp','dpm','ugrd10m','vgrd10m','hs_sw','tp_sw','dpm_sw']
        for varname in varnames:
            # print('...checking grid for: {}'.format(varname.title()))

            parori = dsori[varname]; parmsl = dsmsl[varname]
            diff = parori - parmsl
            rdiff = diff/parori
            if rdiff.max() > 0.05:
                errors.append("error: Maximum Relative {} difference = {:g} %".format(varname.title(), rdiff.max()*100))

        # assert no error message has been registered, else print messages
        assert not errors, "grid test - errors occured:\n{}".format("\n".join(errors))    

    def test_param(self):        
        hsori = read_swan(self.ORIDIR+'/out/pt01.spec').spec.hs().values
        hsmsl = read_swan(self.MSLDIR+'/out/pt01.spec').spec.hs().values
        tmori = read_swan(self.ORIDIR+'/out/pt01.spec').spec.tm01().values
        tmmsl = read_swan(self.MSLDIR+'/out/pt01.spec').spec.tm01().values
        dpori = read_swan(self.ORIDIR+'/out/pt01.spec').spec.dpm().values
        dpmsl = read_swan(self.MSLDIR+'/out/pt01.spec').spec.dpm().values
        
        ratio_hs = (hsori-hsmsl)/hsori
        ratio_tm = (tmori-tmmsl)/tmori
        ratio_dp = (dpori-dpmsl)/dpori

        if ratio_hs.max() > 0.05:
            errors.append("error in hs, rdif={}".format(ratio_hs))
        if ratio_tm.max() > 0.05:
            errors.append("error in tm, rdif={}".format(ratio_tm))
        if ratio_dp.max() > 0.05:
            errors.append("error in dp, rdif={}".format(ratio_dp))

        # assert no error message has been registered, else print messages
        assert not errors, "errors occured:\n{}".format("\n".join(errors))        

    # def test_spec(self):
    #     "test spectral output"