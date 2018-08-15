import os
import subprocess
import shutil
import pytest
from datetime import datetime
from nco import Nco
import logging

from wavespectra import read_swan
import xarray as xr


BASEDIR = '/home/metocean'
REFDIR = os.path.join(BASEDIR, 'swan-ref')
MSLDIR = os.path.join(BASEDIR, 'swan-msl')
TARBALL = os.path.join(BASEDIR, 'tinyapp.tar.gz')
CTLDIR  = os.path.join(BASEDIR, 'tinyapp')
tarjob = os.system('tar -xzvf {} -C {}'.format(TARBALL, BASEDIR))

# RUN PREVIOUS SWAN SRC VERSION
if not os.path.exists(REFDIR): shutil.copytree(CTLDIR, REFDIR)
os.chdir(REFDIR)
os.system('rm -rf out/*')
jobstr = 'mpiexec -n 2 swan-ref.exe par.20180513_00z.swn'
os.system(jobstr)
shutil.move('out/', BASEDIR+'/src-results')
shutil.move(BASEDIR+'/src-results/out', BASEDIR+'/src-results/out-ref')

# RUN MSL SWAN SRC
if not os.path.exists(MSLDIR): shutil.copytree(CTLDIR, MSLDIR)
os.chdir(MSLDIR)
os.system('rm -rf out/*')
jobstr = 'mpiexec -n 2 swan.exe par.20180513_00z.swn'
shutil.move('out/', BASEDIR+'/src-results')

''' compare results (grid, point output and spectra) '''
dsref = xr.open_dataset(REFDIR+'/out/par.20180513_00z.nc')
dsmsl = xr.open_dataset(MSLDIR+'/out/par.20180513_00z.nc')
# grid
varnames = ['hs','tp','dpm','ugrd10m','vgrd10m','hs_sw','tp_sw','dpm_sw']
for varname in varnames:
    print('...checking grid for: {}'.format(varname.title()))

    parori = dsref[varname]; parmsl = dsmsl[varname]
    diff = parori - parmsl
    rdiff = diff/parori
    if rdiff.max() > 0.05:
        raise Exception('Maximum Relative {} difference = {:g} %'.format(varname.title(), rdiff.max()*100))

# point output
hsref = read_swan(REFDIR+'/out/pt01.spec').spec.hs().values
hsmsl = read_swan(MSLDIR+'/out/pt01.spec').spec.hs().values
tmref = read_swan(REFDIR+'/out/pt01.spec').spec.tm01().values
tmmsl = read_swan(MSLDIR+'/out/pt01.spec').spec.tm01().values
dpref = read_swan(REFDIR+'/out/pt01.spec').spec.dpm().values
dpmsl = read_swan(MSLDIR+'/out/pt01.spec').spec.dpm().values

ratio_hs = (hsref-hsmsl)#/hs_ref
ratio_tm = (tmref-tmmsl)#/tm_ref
ratio_dp = (dpref-dpmsl)#/dp_ref

if max(ratio_hs) > 0.05:
    raise Exception("error in hs, rdif={} > 0.05".format(ratio_hs))
if max(ratio_tm) > 0.05:
    raise Exception("error in tm, rdif={} > 0.05".format(ratio_tm))
if max(ratio_dp) > 0.05:
    raise Exception("error in dp, rdif={} > 0.05".format(ratio_dp))
