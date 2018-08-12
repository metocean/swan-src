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
ORIDIR = os.path.join(BASEDIR, 'swan-ori')
MSLDIR = os.path.join(BASEDIR, 'swan-msl')
TARBALL = os.path.join(BASEDIR, 'tinyapp.tar.gz')
CTLDIR  = os.path.join(BASEDIR, 'tinyapp')
tarjob = os.system('tar -xzvf {} -C {}'.format(TARBALL, BASEDIR))

# # RUN ORIGINAL SWAN SRC
if not os.path.exists(ORIDIR): shutil.copytree(CTLDIR, ORIDIR)
os.chdir(ORIDIR)
os.system('rm -rf out/*')
jobstr = 'mpiexec -n 2 swan-ori.exe par.20180513_00z.swn'
os.system(jobstr)

# RUN MSL SWAN SRC
if not os.path.exists(MSLDIR): shutil.copytree(CTLDIR, MSLDIR)
os.chdir(MSLDIR)
os.system('rm -rf out/*')
jobstr = 'mpiexec -n 2 swan.exe par.20180513_00z.swn'
os.system(jobstr)

''' compare results (grid, point output and spectra) '''
dsori = xr.open_dataset(ORIDIR+'/out/par.20180513_00z.nc')
dsmsl = xr.open_dataset(MSLDIR+'/out/par.20180513_00z.nc')
# grid
varnames = ['hs','tp','dpm','ugrd10m','vgrd10m','hs_sw','tp_sw','dpm_sw']
for varname in varnames:
    print('...checking grid for: {}'.format(varname.title()))

    parori = dsori[varname]; parmsl = dsmsl[varname]
    diff = parori - parmsl
    rdiff = diff/parori
    if rdiff.max() > 0.05:
        raise Exception('Maximum Relative {} difference = {:g} %'.format(varname.title(), rdiff.max()*100))

# point output
hsori = read_swan(ORIDIR+'/out/pt01.spec').spec.hs().values
hsmsl = read_swan(MSLDIR+'/out/pt01.spec').spec.hs().values
tmori = read_swan(ORIDIR+'/out/pt01.spec').spec.tm01().values
tmmsl = read_swan(MSLDIR+'/out/pt01.spec').spec.tm01().values
dpori = read_swan(ORIDIR+'/out/pt01.spec').spec.dpm().values
dpmsl = read_swan(MSLDIR+'/out/pt01.spec').spec.dpm().values

ratio_hs = (hsori-hsmsl)#/hs_ori
ratio_tm = (tmori-tmmsl)#/tm_ori
ratio_dp = (dpori-dpmsl)#/dp_ori

if max(ratio_hs) > 0.05:
    raise Exception("error in hs, rdif={} > 0.05".format(ratio_hs))
if max(ratio_tm) > 0.05:
    raise Exception("error in tm, rdif={} > 0.05".format(ratio_tm))
if max(ratio_dp) > 0.05:
    raise Exception("error in dp, rdif={} > 0.05".format(ratio_dp))
