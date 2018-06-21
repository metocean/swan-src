##############################################################################
# IA32_Intel/x86-64_Intel:	Intel Pentium with Linux using Intel compiler 11.
##############################################################################
F90_SER = ifort
F90_OMP = ifort
F90_MPI = mpif90
FLAGS_OPT   = -O2 -prec-div -prec-sqrt -fimf-arch-consistency=true
FLAGS_MSC = -static -W0 -assume byterecl -traceback -diag-disable 8290 -diag-disable 8291 -diag-disable 8293
FLAGS90_MSC = $(FLAGS_MSC)
FLAGS_DYN = -fPIC
FLAGS_SER =
FLAGS_OMP = -openmp
FLAGS_MPI = -fc=ifort
NETCDFROOT = /usr
ifneq ($(NETCDFROOT),)
  INCS_SER = -I$(NETCDFROOT)/include
  INCS_OMP = -I$(NETCDFROOT)/include
  INCS_MPI = -I$(NETCDFROOT)/include
  LIBS_SER = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf
  LIBS_OMP = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf
  LIBS_MPI = -L$(NETCDFROOT)/lib -lnetcdff -lnetcdf
  NCF_OBJS = nctablemd.o agioncmd.o swn_outnc.o
else
  INCS_SER = -I/usr/include
  INCS_OMP = -I/usr/include
  INCS_MPI = -I/usr/include
  LIBS_SER = -L/usr/lib -lnetcdff -lnetcdf
  LIBS_OMP = -L/usr/lib -lnetcdff -lnetcdf
  LIBS_MPI = -L/usr/lib -lnetcdff -lnetcdf
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
