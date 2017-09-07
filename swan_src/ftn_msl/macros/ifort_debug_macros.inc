# ------------------------------------------------------------------------------
F90_SER	    = ifort
F90_OMP	    = ifort
F90_MPI	    = mpif90
FLAGS_OPT   = -g
FLAGS_MSC   = -W0 -assume byterecl -traceback \
              -diag-disable 8291 -diag-disable 10006 -diag-disable 10157 
FLAGS90_MSC = $(FLAGS_MSC)
FLAGS_SER   =
FLAGS_OMP   = -openmp
FLAGS_MPI   = -fc=ifort
INCS_SER    = -I/usr/include -I/usr/lib64/gfortran/modules
INCS_OMP    =
INCS_MPI    = -I/usr/include -I/usr/lib64/gfortran/modules
LIBS_SER    = -L/usr/lib -lnetcdf -lnetcdff
LIBS_OMP    =
LIBS_MPI    = -L/usr/lib -lnetcdf -lnetcdff
O_DIR       = ../work/odir4/
OUT         = -o 
EXTO        = o
MAKE        = make
RM          = rm -f
swch        = -unix -impi
