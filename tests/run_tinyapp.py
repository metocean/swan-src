import os
import subprocess
import logging
from datetime import datetime
from nco import Nco

MODELDIR = '/source/swan-src/tests/tinyapp'
os.chdir(MODELDIR)

TESTDIR = "{:%Y%m%d%H%M%S}".format(datetime.now())
os.makedirs(TESTDIR) # create new folder with time name
os.chmod(TESTDIR, 0o777)
os.system('rsync -a * '+TESTDIR+'/ --exclude '+TESTDIR) # copy test files to new folder

os.chdir(TESTDIR)
os.system('rm -rf out/*') # copy test files to new folder
os.system('mpiexec -n 2 swan.exe par.20180513_00z.swn')

# compare results from newly build model with old one
oldfile  = '../out/par.20180513_00z.nc'
newfile  = './out/par.20180513_00z.nc'
diffile  = './dif.nc'
rdiffile = './reldif.nc'
maxfile  = './maxdif.nc'
command  = ('ncdiff', oldfile, newfile, diffile) 
subprocess.call(command)
command  = ('ncbo','--op_typ=/', diffile, oldfile, rdiffile)
subprocess.call(command)

# define min/max/avg values of the difference
nco = Nco()
hsmax = nco.ncwa(input=rdiffile, op_typ='max', variable=['hs','tp'], output=maxfile, returnArray='hs').data
tpmax = nco.ncwa(input=rdiffile, op_typ='max', variable=['hs','tp'], output=maxfile, returnArray='tp').data

if hsmax>0.05: logging.warning(' Maximum Relative Hs difference = %g %%' %(hsmax*100))
if tpmax>0.05: logging.warning(' Maximum Relative Tp difference = %g %%' %(tpmax*100))