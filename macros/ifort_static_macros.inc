# ------------------------------------------------------------------------------
F90_SER     = ifort
F90_OMP     = ifort
F90_MPI     = mpif90
FLAGS_OPT   = -O2
FLAGS_MSC   = -static -W0 -assume byterecl -traceback \
              -diag-disable 8291 -diag-disable 10006 -diag-disable 10157 
FLAGS90_MSC = $(FLAGS_MSC)
FLAGS_SER   =
FLAGS_OMP   = -openmp
FLAGS_MPI   = -fc=ifort
INCS_SER    = -I/usr/include 
INCS_OMP    =
INCS_MPI    = -I/usr/include 
LIBS_SER    = -L/usr/lib -lnetcdff -lnetcdf
LIBS_OMP    =
LIBS_MPI    = -L/usr/lib -lnetcdff -lnetcdf
O_DIR       = ../work/odir4/
OUT         = -o 
EXTO        = o
MAKE        = make
RM          = rm -f
swch        = -unix -impi
