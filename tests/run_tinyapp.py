import os
import subprocess
import logging
import shutil
from collections import OrderedDict
from datetime import datetime
from nco import Nco, custom

nco = Nco()

BASEDIR = '/home/metocean'
TESTDIR = os.path.join(BASEDIR, 'tinyapp')
TARBALL = os.path.join(BASEDIR, 'tinyapp.tar.gz')

os.system('tar -xzvf {} -C {}'.format(TARBALL, BASEDIR))
os.chdir(TESTDIR)

jobstr = 'mpiexec -n 2 swan.exe par.20170101_00z_msl.swn'
os.system(jobstr)

oldfile  = os.path.join(TESTDIR, 'out/grid_out_native.nc')
newfile  = os.path.join(TESTDIR, 'out/grid_out_msl.nc')
diffile  = os.path.join(TESTDIR, 'dif.nc')
rdiffile = os.path.join(TESTDIR, 'reldif.nc')

# Rename variables in old file
var_mapping = OrderedDict((
    ('theta0', 'thetam'),
))
dim_mapping = OrderedDict((
    ('lon', 'longitude'),
    ('lat', 'latitude'),
))
nco.ncrename(input=oldfile, options=[
    custom.Rename("variable", var_mapping),
    # custom.Rename("dimension", dim_mapping)
])

# compare results from newly build model with old one
command  = ('ncdiff', oldfile, newfile, diffile) 
subprocess.call(command)
command  = ('ncbo','--op_typ=/', diffile, oldfile, rdiffile)
subprocess.call(command)

# define min/max/avg values of the difference
varnames = ['xcur','ycur','xwnd','ywnd','depth','hs','tps','thetam','tm01','tm02']

for varname in varnames:
    print('...checking: {}'.format(varname))
    maxfile  = './maxdif-{}.nc'.format(varname)
    varmax = nco.ncwa(input=rdiffile, op_typ='max', variable=[varname], output=maxfile, returnArray=varname).data

    if varmax > 0.01:
        raise Exception('Maximum Relative {} difference = {:g} %'.format(varname.title(), varmax*100))
