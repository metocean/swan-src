##############################################################################
# AMD64 with Linux using Pathscale compiler
# Note:##############################################################################
F90_DB = ifort
F90_SER = ifort
F90_OMP = ifort
F90_MPI = /usr/local/intel/bin/mpif90
FLAGS_OPT =-O3 -no-prec-div
FLAGS_MSC =#-traceback -CB
FLAGS_SER =
FLAGS_OMP = -openmp -fpp -O1 
FLAGS_MPI =
FLAGS_NC = 
INCS_SER =
INCS_OMP =-I/usr/local/intel/include
INCS_MPI =-I/usr/local/intel/include
INCS_NC = -I/usr/local/intel/include
LIBS_SER = 
LIBS_OMP =
LIBS_MPI =-L/usr/local/intel/lib/ -lmpichf90 -lmpich -pthread -lmpl
LIBS_NC = /usr/local/netcdf3/lib/libnetcdf.a
OUT = -o
EXTO = o
MAKE = make
RM = rm -f
swch = -unix -f95 #-wam4
