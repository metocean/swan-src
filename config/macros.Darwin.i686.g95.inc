################################################################################
# i686_G95:	Intel i686 with Darwin (Mac OSX) using G95 compiler
# Note: OpenMP is not available with G95
################################################################################
F90_SER = g95
F90_OMP = NO_OPENMP_WITH_G95
F90_MPI = mpif90
FLAGS_OPT = -O3
FLAGS_MSC = -Wno=155 -fno-second-underscore -fendian=big
FLAGS_F90_MSC = $(FLAGS_MSC) -ffree-line-length-huge
FLAGS_SER =
FLAGS_OMP =
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
