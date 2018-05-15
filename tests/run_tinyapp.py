import os
import subprocess

MODELDIR = '/source/swan-src/tests/tinyapp'

os.chdir(MODELDIR)
os.makedirs()

os.system('mpiexec -n 2 swan.exe par.20180513_00z.swn')