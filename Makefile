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

SWAN_OBJS = \
swmod1.$(EXTO) \
swmod2.$(EXTO) \
swmod3.$(EXTO) \
ncswan.$(EXTO) \
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
ocpids.$(EXTO) \
ocpcre.$(EXTO) \
ocpmix.$(EXTO)


.SUFFIXES: .f .F .for

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
	@perl switch.pl $(swch) -ncom *.ftn
	$(MAKE) FOR=$(F90_SER) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC)" LIBS="$(LIBS_SER) $(LIBS_NC)" $(SWAN_EXE)

ser:
	@perl switch.pl $(swch) *.ftn
	$(MAKE) FOR=$(F90_SER) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC)" LIBS="$(LIBS_SER) $(LIBS_NC)" $(SWAN_EXE)

ser_db:
	@perl switch.pl $(swch) *.ftn
	$(MAKE) FOR=$(F90_DB) FFLAGS="-g $(FLAGS_MSC) $(FLAGS_SER)" \
                INCS="$(INCS_SER) $(INCS_NC)" LIBS="$(LIBS_SER) $(LIBS_NC)" $(SWAN_EXE)

omp:
	@perl switch.pl $(swch) -omp *.ftn
	$(MAKE) FOR=$(F90_OMP) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_OMP)" \
                INCS="$(INCS_OMP)" LIBS="$(LIBS_OMP)" $(SWAN_EXE)

mpi:
	@perl switch.pl $(swch) -mpi *.ftn
	$(MAKE) FOR=$(F90_MPI) FFLAGS="$(FLAGS_OPT) $(FLAGS_MSC) $(FLAGS_MPI)" \
                INCS="$(INCS_MPI) $(INCS_NC)" LIBS="$(LIBS_MPI) $(LIBS_NC)" $(SWAN_EXE)

doc:
	$(MAKE) -f Makefile.latex TARGET=swanuse doc
	$(MAKE) -f Makefile.latex TARGET=swantech doc
	$(MAKE) -f Makefile.latex TARGET=swanimp doc
	$(MAKE) -f Makefile.latex TARGET=swanpgr doc
	$(MAKE) -f Makefile.latex TARGET=latexfordummies doc

$(SWAN_EXE): $(SWAN_OBJS)
	$(FOR) $(SWAN_OBJS) $(FFLAGS) $(OUT)$(SWAN_EXE) $(INCS) $(LIBS)

.f.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.F.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.for.o:
	$(FOR) $< -c $(FFLAGS) $(INCS)

.for.obj:
	$(FOR) $< -c $(FFLAGS) $(INCS)

clean:
	$(RM) *.$(EXTO) *.mod

allclean:
	$(RM) *.$(EXTO) *.mod *.f ocp*.F sw*.F *.for $(SWAN_EXE)

cleandoc:
	$(MAKE) -f Makefile.latex TARGET=swanuse cleandoc
	$(MAKE) -f Makefile.latex TARGET=swantech cleandoc
	$(MAKE) -f Makefile.latex TARGET=swanimp cleandoc
	$(MAKE) -f Makefile.latex TARGET=swanpgr cleandoc
	$(MAKE) -f Makefile.latex TARGET=latexfordummies cleandoc
