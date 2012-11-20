################################################################################
# i686_GNU:	Intel i686 with Linux using GNU compilers (gcc/gfortran)
################################################################################
F90_SER = gfortran
F90_OMP = gfortran
F90_MPI = mpif90
FLAGS_OPT = -O3
FLAGS_MSC = -fno-second-underscore -fconvert=big-endian
FLAGS_F90_MSC = $(FLAGS_MSC) -ffree-line-length-none
FLAGS_SER =
FLAGS_OMP = -fopenmp
FLAGS_MPI =
INCS_SER =
INCS_OMP =
INCS_MPI =
LIBS_SER =
LIBS_OMP =
LIBS_MPI =
OUT = -o 
EXTO = o
MAKE = make
RM = rm -f
swch = -unix -timg -f95
################################################################################
