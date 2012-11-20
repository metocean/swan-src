################################################################################
# SGI Altix (IA64) using Intel
################################################################################
F90_SER = ifort
F90_OMP = ifort
F90_MPI = ifort
FLAGS_OPT = -O3 -mp
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
LIBS_MPI = -lmpi -lscs
OUT = -o 
EXTO = o
MAKE = make
RM = rm -f
swch = -unix -timg -f95
################################################################################
