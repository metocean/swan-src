# ------------------------------------------------------------------------------
#                      Makefile for building SWAN program and documentation
# ------------------------------------------------------------------------------
#
# Before compilation, type "make config" first!
#
# To compile the serial executable type "make ser"
# To compile the OpenMP executable type "make omp"
# To compile the MPI executable type "make mpi"
#
# To remove compiled objects and modules: type "make clean"
#
# To remove compiled objects, modules and executable: type "make allclean"
#
# To compile the SWAN documentation type "make doc"
#
# To remove the PDF and HTML documents type "make cleandoc"
#
# Please do not change anything below, unless you're very sure what you're doing
# ------------------------------------------------------------------------------

include macros.inc

SWAN_EXE = swan.exe

SWAN_MODS = \
swmod1.$(EXTO) \
swmod2.$(EXTO) \
ncswan.$(EXTO) \
m_constants.$(EXTO) \
m_fileio.$(EXTO) \
serv_xnl4v5.$(EXTO) \
mod_xnl4v5.$(EXTO) \
SwanGriddata.$(EXTO) \
SwanGridobjects.$(EXTO) \
SwanCompdata.$(EXTO)

SWAN_OBJS=    \
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
SwanInterpolatePoint.$(EXTO) \
SwanInterpolateAc.$(EXTO) \
SwanInterpolateOutput.$(EXTO) \
SwanConvAccur.$(EXTO) \
SwanConvStopc.$(EXTO) \
SwanFindObstacles.$(EXTO) \
SwanCrossObstacle.$(EXTO) \
SwanComputeForce.$(EXTO) \
SwanIntgratSpc.$(EXTO) \
SwanGSECorr.$(EXTO) \
SwanDiffPar.$(EXTO) \
ocpids.$(EXTO) \
ocpcre.$(EXTO) \
ocpmix.$(EXTO)

NCOM_OBJS= \
pass_out_swan.$(EXTO) \
pass_in_swan.$(EXTO) \
master_time_ctr.$(EXTO)

INCS_NCOM=-I../../NCOM/build

.SUFFIXES: .f .F .for .f90 .F90

.PHONEY: help

help:
	@echo "This Makefile supports the following:"
	@echo "make config    -- makes machine-dependent macros include file"
	@echo "make ser       -- makes the Serial $(SWAN_EXE) executable"
	@echo "make omp       -- makes the OpenMP $(SWAN_EXE) executable"
	@echo "make mpi       -- makes the    MPI $(SWAN_EXE) executable"
	@echo "make doc       -- makes the SWAN documentation (PDF)"
	@echo "make clean     -- removes compiled objects and modules"
	@echo "make allclean  -- removes compiled objects, modules and $(SWAN_EXE)"
	@echo "make cleandoc  -- removes all SWAN documents"
	@echo "make hotcat    -- makes the hotfile concatenator"
	@echo "make ncom      -- makes the SWAN NCOM lib"

config:
	@perl platform.pl

install:
	@perl platform.pl

hotcat:
	@perl switch.pl $(swch) swanhcat.ftn
	$(F90_SER) swanhcat.f $(FLAGS_OPT) $(FLAGS_SER) $(INCS_SER) $(LIBS_SER) $(OUT)swan_hotcat.exe

ncom:	
	@perl switch.pl $(swch) -ncom *.ftn *.ftn90
	$(MAKE) FOR=$(F90_SER) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC) $(INCS_NCOM)" LIBS="$(LIBS_SER) $(LIBS_NC)" LIB_OUT="libswan.a" ncom_lib

ncom_db:
	@perl switch.pl $(swch) -ncom *.ftn *.ftn90
	$(MAKE) FOR=$(F90_SER) FFLAGS=" -g $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC) $(INCS_NCOM)" LIBS="$(LIBS_SER) $(LIBS_NC)" LIB_OUT="libswan_db.a" ncom_lib

ser:
	@perl switch.pl $(swch) *.ftn *.ftn90
	$(MAKE) FOR=$(F90_SER) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC)" LIBS="$(LIBS_SER) $(LIBS_NC)" $(SWAN_EXE)

ser_db:
	@perl switch.pl $(swch) *.ftn *.ftn90
	$(MAKE) FOR=$(F90_DB) FFLAGS="-g $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC)" LIBS="$(LIBS_SER) $(LIBS_NC)" $(SWAN_EXE)

omp:
	@perl switch.pl $(swch) -omp *.ftn *.ftn90
	$(MAKE) FOR=$(F90_OMP) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_OMP)" \
                INCS="$(INCS_OMP)" LIBS="$(LIBS_OMP)" $(SWAN_EXE)

mpi:
	@perl switch.pl $(swch) -mpi *.ftn *.ftn90
	$(MAKE) FOR=$(F90_MPI) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_MPI)" \
                INCS="$(INCS_MPI) $(INCS_NC)" LIBS="$(LIBS_MPI) $(LIBS_NC)" $(SWAN_EXE)

mpi_db:
	@perl switch.pl $(swch) -mpi *.ftn *.ftn90
	$(MAKE) FOR=$(F90_DB) FFLAGS="-g $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC)" LIBS="$(LIBS_MPI) $(LIBS_NC)" $(SWAN_EXE)


doc:
	$(MAKE) -f Makefile.latex TARGET=swanuse doc
	$(MAKE) -f Makefile.latex TARGET=swantech doc
	$(MAKE) -f Makefile.latex TARGET=swanimp doc
	$(MAKE) -f Makefile.latex TARGET=swanpgr doc
	$(MAKE) -f Makefile.latex TARGET=latexfordummies doc

$(SWAN_EXE): $(SWAN_MODS) $(SWAN_OBJS)
	$(FOR) $(SWAN_OBJS) $(SWAN_MODS) $(FFLAGS) -static $(OUT)$(SWAN_EXE) $(LIBS)

ncom_lib: $(SWAN_MODS) $(SWAN_OBJS) $(NCOM_OBJS)
	xiar rcs $(LIB_OUT) $(SWAN_OBJS) $(SWAN_MODS) $(NCOM_OBJS)
	

.f.o:
	$(FOR) $(INCS) $< -c $(FFLAGS)

.F.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.f90.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.F90.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.for.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.for.obj:
	$(FOR) $< -c $(FFLAGS) $(INCS)

clean:
	$(RM) *.$(EXTO) *.mod *.f *.f90

allclean:
	$(RM) *.$(EXTO) *.mod *.f *.f90 $(SWAN_EXE)

cleandoc:
	$(MAKE) -f Makefile.latex TARGET=swanuse cleandoc
	$(MAKE) -f Makefile.latex TARGET=swantech cleandoc
	$(MAKE) -f Makefile.latex TARGET=swanimp cleandoc
	$(MAKE) -f Makefile.latex TARGET=swanpgr cleandoc
	$(MAKE) -f Makefile.latex TARGET=latexfordummies cleandoc
