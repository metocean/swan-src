################################################################################
# IA32_Intel/x86-64_Intel:	Intel Core/Xeon with Linux using Intel compiler.
################################################################################
F90_SER = ifx
F90_OMP = ifx
F90_MPI = mpifort
FLAGS_OPT = -O3 -xHost
FLAGS_MSC = -W0 -assume byterecl -traceback -diag-disable 8290 -diag-disable 8291 -diag-disable 8293
FLAGS90_MSC = $(FLAGS_MSC)
FLAGS_DYN = -fPIC
FLAGS_SER =
FLAGS_OMP = -qopenmp
FLAGS_MPI = -fc=ifx
NETCDFROOT = $(NETCDF_HOME)
ifneq ($(NETCDFROOT),)
  INCS_SER = -I$(NETCDFROOT)/include
  INCS_OMP = -I$(NETCDFROOT)/include
  INCS_MPI = -I$(NETCDFROOT)/include
  LIBS_SER = -L$(NETCDFROOT)/lib -L$(HDF5_HOME)/lib -L$(ZHOME)/lib -lnetcdf -lnetcdff -lhdf5_hl -lhdf5 -lm -lz
  LIBS_OMP = -L$(NETCDFROOT)/lib -L$(HDF5_HOME)/lib -L$(ZHOME)/lib -lnetcdf -lnetcdff -lhdf5_hl -lhdf5 -lm -lz
  LIBS_MPI = -L$(NETCDFROOT)/lib -L$(HDF5_HOME)/lib -L$(ZHOME)/lib -lnetcdf -lnetcdff -lhdf5_hl -lhdf5 -lm -lz
  NCF_OBJS = nctablemd.o agioncmd.o swn_outnc.o
else
  INCS_SER =
  INCS_OMP =
  INCS_MPI =
  NCF_OBJS =
endif
OUT = -o 
EXTO = o
MAKE = make
RM = rm -f
ifneq ($(NETCDFROOT),)
  swch = -unix -impi -netcdf
else
  swch = -unix -impi
endif
