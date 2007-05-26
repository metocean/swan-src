##############################################################################
# IA32_Compaq:		Intel Pentium with MS Windows using Compaq compiler
##############################################################################
F90_SER = f90
F90_OMP =
F90_MPI = f90
FLAGS_OPT = /optimize:5
FLAGS_MSC = /assume:byterecl /nowarn /nologo
FLAGS_SER =
FLAGS_OMP =
FLAGS_MPI =
INCS_SER =
INCS_OMP =
INCS_MPI = /include:"c:\progra~1\MPICH\SDK\include"
LIBS_SER =
LIBS_OMP =
LIBS_MPI = c:\progra~1\MPICH\SDK\lib\mpe.lib c:\progra~1\MPICH\SDK\lib\mpich.lib
OUT = /exe:
EXTO = obj
MAKE = nmake
RM = del
swch = -dos -f95 -impi -cvis -timg
