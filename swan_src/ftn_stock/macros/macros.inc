##############################################################################
# IA32_GNU:		Intel Pentium with Linux using GNU compiler gfortran.
##############################################################################
F90_SER = gfortran
F90_OMP = gfortran
F90_MPI = mpif90
FLAGS_OPT = -O
FLAGS_MSC = -w -fno-second-underscore
FLAGS90_MSC = $(FLAGS_MSC) -ffree-line-length-none
FLAGS_DYN = -fPIC
FLAGS_SER =
FLAGS_OMP = -fopenmp
FLAGS_MPI =
NETCDFROOT = /usr/local
ifneq ($(NETCDFROOT),)
  INCS_SER = -I$(NETCDFROOT)/include
  INCS_OMP = -I$(NETCDFROOT)/include
  INCS_MPI = -I$(NETCDFROOT)/include
  LIBS_SER = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lz -ldl -lm
  LIBS_OMP = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lz -ldl -lm
  LIBS_MPI = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lz -ldl -lm
  NCF_OBJS = nctablemd.o agioncmd.o swn_outnc.o
else
  INCS_SER = /usr/include
  INCS_OMP = /usr/include
  INCS_MPI = /usr/include
  LIBS_SER = /usr/lib/x86_64-linux-gnu -lnetcdf -lnetcdff
  LIBS_OMP = /usr/lib/x86_64-linux-gnu -lnetcdf -lnetcdff -static-libgcc
  LIBS_MPI = /usr/lib/x86_64-linux-gnu -lnetcdf -lnetcdff
  NCF_OBJS = nctablemd.o agioncmd.o swn_outnc.o
endif
O_DIR = ../work/odir4/
OUT = -o 
EXTO = o
MAKE = make
RM = rm -f
ifneq ($(NETCDFROOT),)
  swch = -unix -netcdf
else
  swch = -unix
endif
