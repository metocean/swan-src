import os
import subprocess
import logging
import shutil
from datetime import datetime
from nco import Nco

BASEDIR = '/home/metocean'
TESTDIR = os.path.join(BASEDIR, "{:%Y%m%d%H%M%S}".format(datetime.now()))
CTRLDIR = os.path.join(BASEDIR, 'tinyapp')
TARBALL = '/source/swan-src/tests/tinyapp.tar.gz'

os.system('tar -xzvf {} -C {}'.format(TARBALL, BASEDIR))
shutil.copytree(CTRLDIR, TESTDIR)
os.chdir(TESTDIR)

os.system('rm -rf out/*') # copy test files to new folder
jobstr = 'mpiexec -n 2 swan.exe par.20180513_00z.swn'
os.system(jobstr)

# compare results from newly build model with old one
oldfile  = os.path.join(CTRLDIR, 'out/par.20180513_00z.nc')
newfile  = os.path.join(TESTDIR, './out/par.20180513_00z.nc')
diffile  = os.path.join(TESTDIR, './dif.nc')
rdiffile = os.path.join(TESTDIR, './reldif.nc')
command  = ('ncdiff', oldfile, newfile, diffile) 
subprocess.call(command)
command  = ('ncbo','--op_typ=/', diffile, oldfile, rdiffile)
subprocess.call(command)

# define min/max/avg values of the difference
nco = Nco()
varnames = ['hs','tp','dpm','ugrd10m','vgrd10m','hs_sw','tp_sw','dpm_sw']
for varname in varnames:
    print('...checking: {}'.format(varname))
    maxfile  = './maxdif-{}.nc'.format(varname)
    varmax = nco.ncwa(input=rdiffile, op_typ='max', variable=[varname], output=maxfile, returnArray=varname).data

    if varmax > 0.05:
        raise Exception('Maximum Relative {} difference = {:g} %'.format(varname.title(), varmax*100))
