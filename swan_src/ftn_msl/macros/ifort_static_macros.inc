# ------------------------------------------------------------------------------
F90_SER     = ifort
F90_OMP     = ifort
F90_MPI     = mpif90
FLAGS_OPT   = -O2 -prec-div -prec-sqrt -fimf-arch-consistency=true
FLAGS_MSC   = -static -W0 -assume byterecl -traceback \
              -diag-disable 8291 -diag-disable 10006 -diag-disable 10157 
FLAGS90_MSC = $(FLAGS_MSC)
FLAGS_SER   =
FLAGS_OMP   = -openmp
FLAGS_MPI   = -fc=ifort
INCS_SER    = -I/usr/local/include 
INCS_OMP    =
INCS_MPI    = -I/usr/local/include 
LIBS_SER    = -L/usr/local/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lz
LIBS_OMP    =
LIBS_MPI    = -L/usr/local/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lz
O_DIR       = ../work/odir4/
OUT         = -o 
EXTO        = o
MAKE        = make
RM          = rm -f
swch        = -unix -impi
