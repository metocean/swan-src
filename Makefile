# ------------------------------------------------------------------------------
#                      Makefile for building SWAN program and documentation
# ------------------------------------------------------------------------------
#
# Before compilation, copy the appropriate macros file in config to macros.inc
#
# To compile the serial executable type "make ser"
# To compile the OpenMP executable type "make omp"
# To compile the MPI executable type "make mpi"
#
# To remove compiled objects and modules: type "make clean"
#
# To remove compiled objects, modules and executable: type "make clobber"
#
# Please do not change anything below, unless you're very sure what you're doing
# ------------------------------------------------------------------------------

include macros.inc
-include depend.mk


# ------------------------------------------------------------------------------
# Modify settings to build with ESMF
# Note: ESMF_DIR must be set when compiling with ESMF
# ------------------------------------------------------------------------------
ifdef ESMF_DIR

# Define ESMF_BOPT (used in ESMF makefile fragment)
ifeq ($(findstring -g,$(FLAGS_OPT)),)
  ESMF_BOPT = O
else
  ESMF_BOPT = g
endif

# Include ESMF make fragment if ESMF_DIR is set
include $(ESMF_DIR)/esmf.mk

endif
# ------------------------------------------------------------------------------


SWAN_EXE = swan.exe

SWAN_OBJS += \
SdsBabanin.$(EXTO) \
swmod1.$(EXTO) \
swmod2.$(EXTO) \
m_constants.$(EXTO) \
m_fileio.$(EXTO) \
serv_xnl4v5.$(EXTO) \
mod_xnl4v5.$(EXTO) \
SwanGriddata.$(EXTO) \
SwanGridobjects.$(EXTO) \
SwanCompdata.$(EXTO) \
swanmain.$(EXTO) \
swanpre1.$(EXTO) \
swanpre2.$(EXTO) \
swancom1.$(EXTO) \
swancom2.$(EXTO) \
swancom3.$(EXTO) \
swancom4.$(EXTO) \
swancom5.$(EXTO) \
swanout1.$(EXTO) \
swanout2.$(EXTO) \
swanser.$(EXTO) \
swanparll.$(EXTO) \
SwanReadGrid.$(EXTO) \
SwanReadADCGrid.$(EXTO) \
SwanReadTriangleGrid.$(EXTO) \
SwanReadEasymeshGrid.$(EXTO) \
SwanInitCompGrid.$(EXTO) \
SwanCheckGrid.$(EXTO) \
SwanCreateEdges.$(EXTO) \
SwanGridTopology.$(EXTO) \
SwanGridVert.$(EXTO) \
SwanGridCell.$(EXTO) \
SwanGridFace.$(EXTO) \
SwanPrintGridInfo.$(EXTO) \
SwanFindPoint.$(EXTO) \
SwanPointinMesh.$(EXTO) \
SwanBpntlist.$(EXTO) \
SwanPrepComp.$(EXTO) \
SwanVertlist.$(EXTO) \
SwanCompUnstruc.$(EXTO) \
SwanDispParm.$(EXTO) \
SwanPropvelX.$(EXTO) \
SwanSweepSel.$(EXTO) \
SwanPropvelS.$(EXTO) \
SwanTranspAc.$(EXTO) \
SwanTranspX.$(EXTO) \
SwanDiffPar.$(EXTO) \
SwanGSECorr.$(EXTO) \
SwanInterpolatePoint.$(EXTO) \
SwanInterpolateAc.$(EXTO) \
SwanInterpolateOutput.$(EXTO) \
SwanConvAccur.$(EXTO) \
SwanConvStopc.$(EXTO) \
SwanFindObstacles.$(EXTO) \
SwanCrossObstacle.$(EXTO) \
SwanComputeForce.$(EXTO) \
SwanIntgratSpc.$(EXTO) \
ocpids.$(EXTO) \
ocpcre.$(EXTO) \
ocpmix.$(EXTO)
ifdef TEST_SWFLD
  FLAGS_MSC += -DTEST_SWFLD
  SWAN_OBJS += swanfield.$(EXTO)
  SWAN_OBJS += w2a.$(EXTO)
  swch += -test_swfld
endif

HCAT_EXE = hcat.exe
HCAT_OBJS = swanhcat.$(EXTO)

.SUFFIXES:
.SUFFIXES: .o .f .F .for .f90 .F90

.PHONEY: help depend clean clobber

help:
	@echo "This Makefile supports the following:"
	@echo "make ser       -- makes the serial $(SWAN_EXE) executable"
	@echo "make omp       -- makes the OpenMP $(SWAN_EXE) executable"
	@echo "make mpi       -- makes the    MPI $(SWAN_EXE) executable"
	@echo "make hcat      -- makes the $(HCAT_EXE) hotfile concatatination executable"
	@echo "make esmf_ser  -- makes the Serial ESMF component"
	@echo "make esmf_omp  -- makes the OpenMP ESMF component"
	@echo "make esmf_mpi  -- makes the    MPI ESMF component"
	@echo "make clean     -- removes compiled objects and modules"
	@echo "make clobber   -- removes compiled objects, modules and $(SWAN_EXE)"

ser: depend
	@perl switch.pl $(swch) *.ftn *.ftn90
	$(MAKE) FOR="$(F90_SER)" \
		FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_SER)" \
	        FFLAGS_F90="$(FLAGS_OPT) $(FLAGS_F90_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER)" LIBS="$(LIBS_SER)" $(SWAN_EXE)

omp: depend
	@perl switch.pl $(swch) -omp *.ftn *.ftn90
	$(MAKE) FOR="$(F90_OMP)" \
		FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_FIX) $(FLAGS_OMP)" \
	        FFLAGS_F90="$(FLAGS_OPT) $(FLAGS_F90_MSC) $(FLAGS_OMP)" \
                INCS="$(INCS_OMP)" LIBS="$(LIBS_OMP)" $(SWAN_EXE)

mpi: depend
	@perl switch.pl $(swch) -mpi *.ftn *.ftn90
	$(MAKE) FOR="$(F90_MPI)" \
		FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_MPI)" \
	        FFLAGS_F90="$(FLAGS_OPT) $(FLAGS_F90_MSC) $(FLAGS_MPI)" \
                INCS="$(INCS_MPI)" LIBS="$(LIBS_MPI)" $(SWAN_EXE)

esmf_ser: depend
	@perl switch.pl $(swch) -esmf *.ftn *.ftn90
	$(MAKE) FOR="$(F90_SER)" \
		FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_SER)" \
	        FFLAGS_F90="$(FLAGS_OPT) $(FLAGS_F90_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(ESMF_F90COMPILEPATHS)" \
		LD="$(ESMF_F90LINKER)" \
		LIBS="$(LIBS_SER) $(ESMF_F90LINKPATHS) $(ESMF_F90ESMFLINKLIBS)" esmf

esmf_omp: depend
	@perl switch.pl $(swch) -esmf -omp *.ftn *.ftn90
	$(MAKE) FOR="$(F90_OMP)" \
		FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_OMP)" \
	        FFLAGS_F90="$(FLAGS_OPT) $(FLAGS_F90_MSC) $(FLAGS_OMP)" \
                INCS="$(INCS_OMP) $(ESMF_F90COMPILEPATHS)" \
		LD="$(ESMF_F90LINKER)" \
		LIBS="$(LIBS_OMP) $(ESMF_F90LINKPATHS) $(ESMF_F90ESMFLINKLIBS)" esmf

esmf_mpi: depend
	@perl switch.pl $(swch) -esmf -mpi *.ftn *.ftn90
	$(MAKE) FOR="$(F90_MPI)" \
		FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_MPI)" \
	        FFLAGS_F90="$(FLAGS_OPT) $(FLAGS_F90_MSC) $(FLAGS_MPI)" \
                INCS="$(INCS_MPI) $(ESMF_F90COMPILEPATHS)" \
		LD="$(ESMF_F90LINKER)" \
		LIBS="$(LIBS_MPI) $(ESMF_F90LINKPATHS) $(ESMF_F90ESMFLINKLIBS)" esmf

esmf: $(SWAN_OBJS) swanesmf.$(EXTO) swanfield.$(EXTO) w2a.$(EXTO)

hcat:
	@perl switch.pl $(swch) swanhcat.ftn
	$(MAKE) FOR="$(F90_SER)" FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_SER)"\
		FFLAGS_F90="$(FLAGS_OPT) $(FLAGS_F90_MSC) $(FLAGS_SER)" \
	        $(HCAT_EXE)

depend:
	@perl make_depend.pl -n -f'ftn|ftn90' -pNONE

$(HCAT_EXE): $(HCAT_OBJS)
	$(FOR) $(HCAT_OBJS) $(FFLAGS) $(OUT)$(HCAT_EXE)

$(SWAN_EXE): $(SWAN_OBJS)
	$(FOR) $(SWAN_OBJS) $(FFLAGS) $(OUT)$(SWAN_EXE) $(INCS) $(LIBS)

.f.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.f90.o:
	$(FOR) $< -c $(FFLAGS_F90) $(INCS)

.F.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.F90.o:
	$(FOR) $< -c $(FFLAGS_F90) $(INCS)

.for.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.for.obj:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.f90.obj:
	$(FOR) $< -c $(FFLAGS_F90) $(INCS)

.F90.obj:
	$(FOR) $< -c $(FFLAGS_F90) $(INCS)

clean:
	$(RM) *.$(EXTO) *.mod *.f *.F *.F90 *.for *.f90 depend.mk

clobber:
	$(RM) *.$(EXTO) *.mod *.f *.F *.F90 *.for *.f90 depend.mk $(SWAN_EXE) $(HCAT_EXE)

allclean:
	$(RM) *.$(EXTO) *.mod *.f *.F *.F90 *.for *.f90 depend.mk $(SWAN_EXE) $(HCAT_EXE)

