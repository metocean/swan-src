################################################################################
# i686_PGI:	Intel i686 with Linux using Portland Group compiler
# Note: -lpgc is required for OpenMP.
################################################################################
F90_SER = pgf90
F90_OMP = pgf90
F90_MPI = mpif90
FLAGS_OPT = -fastsse
FLAGS_MSC = -Mbyteswapio
FLAGS_F90_MSC = $(FLAGS_MSC)
FLAGS_SER =
FLAGS_OMP = -mp=nonuma
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
