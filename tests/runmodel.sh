cd /home/metocean/
tar -xzvf /home/metocean/tinyapp.tar.gz  -C /home/metocean
cp -a /home/metocean/tinyapp /home/metocean/swan-ori
cd /home/metocean/swan-ori
rm -rf out/*
mpiexec -n 2 swan.exe par.20180513_00z.swn