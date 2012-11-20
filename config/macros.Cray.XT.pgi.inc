################################################################################
# Cray XT (AMD Opteron) using PGI
################################################################################
F90_SER = ftn
F90_OMP = ftn
F90_MPI = ftn
FLAGS_OPT = -fastsse
FLAGS_MSC = -Mbyteswapio
FLAGS_F90_MSC = $(FLAGS_MSC)
FLAGS_SER =
FLAGS_OMP = -mp
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
