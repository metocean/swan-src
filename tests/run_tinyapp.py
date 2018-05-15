import os
import subprocess
from datetime import datetime

MODELDIR = '/source/swan-src/tests/tinyapp'
os.chdir(MODELDIR)

TESTDIR = "{:%Y%m%d%H%M%S}".format(datetime.now())
os.makedirs(TESTDIR) # create new folder with time name
os.chmod(TESTDIR, 0o777)
os.system('rsync -a * '+TESTDIR+'/ --exclude '+TESTDIR) # copy test files to new folder

os.chdir(TESTDIR)
os.system('rm -rf out/*') # copy test files to new folder
os.system('mpiexec -n 2 swan.exe par.20180513_00z.swn')

# TODO: compare files with old/original ones using nco/ncdiff for: 
# hmax, hmin, tmax, tmin, hmean, tmean. Create flag if differences are above certain threshold
# ...