################################################################################
# SGI Altix (IA64) using Intel
################################################################################
F90_SER = ifort
F90_OMP = ifort
F90_MPI = ifort
FLAGS_OPT = -O3 -fp-model strict
FLAGS_MSC = -convert big_endian -assume byterecl
FLAGS_F90_MSC = $(FLAGS_MSC)
FLAGS_SER =
FLAGS_OMP = -openmp
FLAGS_MPI =
INCS_SER =
INCS_OMP =
INCS_MPI =
LIBS_SER =
LIBS_OMP =
LIBS_MPI =  -lmkl_lapack -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmpi
OUT = -o 
EXTO = o
MAKE = make
RM = rm -f
swch = -unix -timg -f95
################################################################################
