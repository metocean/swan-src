################################################################################
# RS6000_IBM:           IBM SP with AIX using IBM compiler
################################################################################
F90_SER = xlf90_r
F90_OMP = xlf90_r
F90_MPI = mpxlf90_r
FLAGS_OPT = -O3 -qstrict -qarch=auto -qtune=auto -qnohot -qcache=auto \
            -qunroll -qalign=4k -qfloat=hsflt
FLAGS_MSC = -w -qfixed -qsuffix=cpp=F -qnosave -q64
FLAGS_F90_MSC = -w -qfree -qsuffix=cpp=F90 -qnosave -q64
FLAGS_SER =
FLAGS_OMP = -qsmp=omp
FLAGS_MPI =
INCS_SER =
INCS_OMP =
INCS_MPI =
LIBS_SER = -lessl -lmass
LIBS_OMP = -lessl -lmass
LIBS_MPI = -lessl -lmass
OUT = -o
EXTO = o
MAKE = gmake
RM = rm -f
swch = -unix -timg
################################################################################
