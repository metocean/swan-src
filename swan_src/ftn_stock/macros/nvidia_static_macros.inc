##############################################################################
# IA32_Intel/x86-64_Intel: Intel Pentium with Linux using Intel compiler 17.
##############################################################################
F90_SER = nvfortran
F90_OMP = nvfortran
F90_MPI = mpif90
FLAGS_OPT = -O2
FLAGS_MSC = -static -traceback
FLAGS90_MSC = $(FLAGS_MSC)
FLAGS_DYN = -fPIC
FLAGS_SER =
FLAGS_OMP = -mp
FLAGS_MPI =
NETCDFROOT = /usr/local
ifneq ($(NETCDFROOT),)
  INCS_SER = -I$(NETCDFROOT)/include
  INCS_OMP = -I$(NETCDFROOT)/include
  INCS_MPI = -I$(NETCDFROOT)/include
  LIBS_SER = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz
  LIBS_OMP = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz
  LIBS_MPI = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz
  NCF_OBJS = nctablemd.o agioncmd.o swn_outnc.o
else
  INCS_SER = -I/usr/include -I/usr/include/x86_64-linux-gnu/mpich
  INCS_OMP = -I/usr/include -I/usr/include/x86_64-linux-gnu/mpich
  INCS_MPI = -I/usr/include -I/usr/include/x86_64-linux-gnu/mpich
  LIBS_SER = -L/usr/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz
  LIBS_OMP = -L/usr/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz
  LIBS_MPI = -L/usr/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz
  NCF_OBJS = nctablemd.o agioncmd.o swn_outnc.o
endif
O_DIR = ../work/odir4/
OUT = -o
EXTO = o
MAKE = make
RM = rm -f
ifneq ($(NETCDFROOT),)
  swch = -unix -impi -netcdf
else
  swch = -unix -impi
endif