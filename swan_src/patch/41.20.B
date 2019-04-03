1) changes:
   *) temporary fallback option of triads: original LTA is default with [trfac]=0.05

2) bug fixes:
   *) correction netCDF output in case of multiple non-stationary runs in MPI mode
   *) correct collection multiple output files using different time intervals in parallel unstructured mode

--- agioncmd.ftn90	2017-10-26 07:54:43.000000000 +0200
+++ agioncmd.ftn90	2018-11-30 17:16:14.000000000 +0100
@@ -9,8 +9,6 @@
 !/    1.4     | 11-apr-2014 | bug fixes
 !/                          | reduced memory consumption
 !/
-!/    copyright 2009-2014 bmtargoss
-!/       no unauthorized use without permission.
 !/
 !  1. purpose :
 !
@@ -49,14 +47,14 @@
 !         %points        int        1:npoints
 !         %longitude     r.a        x coordinates points
 !         %latitude      r.a        y coordinates points
-!         %lunit      char       likely unit (meter, degrees)
+!         %lunit         char       likely unit (meter, degrees)
 !         %npoints
 !
 !       spcgrid                     spectral grid
 !         %frequency     r.a        frequency axe
 !         %direction     r.a.       directional axe
-!         %nfreq      int        number of frequencies
-!         %ndir       int        number of directions
+!         %nfreq         int        number of frequencies
+!         %ndir          int        number of directions
 !
 !       nctable          ncttype    struct array from nctablemd.f90
 !         %standard_name char       see remarks a
@@ -138,7 +136,7 @@
         use netcdf
         use nctablemd
         implicit none
-        real, parameter                              :: AGIONCMD_VERSION = 1.4
+        real, parameter                              :: AGIONCMD_VERSION = 1.5
         real, parameter                              :: AGNC_DUMMY = NF90_FILL_FLOAT
         integer(kind=1), parameter                   :: AGNC_FILL_BYTE = -2**7
         integer(kind=2), parameter                   :: AGNC_FILL_SHORT= -2**15
--- HottifySWAN.ftn90	2018-11-30 17:31:10.751334798 +0100
+++ HottifySWAN.ftn90	2018-11-30 17:16:14.000000000 +0100
@@ -7,7 +7,7 @@
 !     This program is specifically meant for unstructured SWAN grids.
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- m_fileio.ftn90	2018-11-30 17:31:10.751334798 +0100
+++ m_fileio.ftn90	2018-11-30 17:16:15.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -83,7 +83,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -371,7 +371,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -427,7 +427,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- mod_xnl4v5.ftn90	2018-11-30 17:31:10.755334788 +0100
+++ mod_xnl4v5.ftn90	2018-11-30 17:16:15.000000000 +0100
@@ -469,7 +469,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -853,7 +853,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1075,7 +1075,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1204,7 +1204,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1461,7 +1461,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1676,7 +1676,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1804,7 +1804,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1911,7 +1911,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2219,7 +2219,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2705,7 +2705,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2858,7 +2858,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3059,7 +3059,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3542,7 +3542,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3855,7 +3855,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4254,7 +4254,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4675,7 +4675,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5145,7 +5145,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5302,7 +5302,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5579,7 +5579,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5882,7 +5882,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6158,7 +6158,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6289,7 +6289,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6526,7 +6526,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6627,7 +6627,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6992,7 +6992,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7219,7 +7219,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7369,7 +7369,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7806,7 +7806,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7908,7 +7908,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8025,7 +8025,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8137,7 +8137,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8267,7 +8267,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8371,7 +8371,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8476,7 +8476,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8915,7 +8915,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- ocpcre.ftn	2018-11-30 17:31:10.755334788 +0100
+++ ocpcre.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -45,7 +45,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -133,7 +133,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -243,7 +243,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -392,7 +392,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -517,7 +517,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -713,7 +713,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -875,7 +875,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1071,7 +1071,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1265,7 +1265,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1410,7 +1410,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1554,7 +1554,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1937,7 +1937,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2046,7 +2046,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2147,7 +2147,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2255,7 +2255,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2367,7 +2367,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2481,7 +2481,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2570,7 +2570,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- ocpids.ftn	2018-11-30 17:31:10.755334788 +0100
+++ ocpids.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -28,7 +28,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -363,7 +363,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -462,7 +462,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -587,7 +587,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- ocpmix.ftn	2018-11-30 17:31:10.755334788 +0100
+++ ocpmix.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -42,7 +42,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -182,7 +182,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -381,7 +381,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -475,7 +475,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -573,7 +573,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -806,7 +806,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1176,7 +1176,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1289,7 +1289,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1437,7 +1437,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1538,7 +1538,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1637,7 +1637,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2007,7 +2007,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2131,7 +2131,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2222,7 +2222,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2416,7 +2416,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2512,7 +2512,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- platform.pl	2017-10-26 07:54:43.000000000 +0200
+++ platform.pl	2018-11-30 17:16:14.000000000 +0100
@@ -216,6 +216,7 @@
     print OUTFILE "##############################################################################\n";
     print OUTFILE "F90_SER = ifort\n";
     print OUTFILE "F90_OMP = ifort\n";
+    print OUTFILE "# if appropriate, use mpiifort of Intel instead\n";
     print OUTFILE "F90_MPI = mpif90\n";
 #    if ($cpu =~ /i686/i) {
 #      print OUTFILE "FLAGS_OPT = -O2 -xN -mp1\n";
@@ -682,6 +683,7 @@
     print OUTFILE "##############################################################################\n";
     print OUTFILE "F90_SER = ifort\n";
     print OUTFILE "F90_OMP = ifort\n";
+    print OUTFILE "# if appropriate, use mpiifort of Intel instead\n";
     print OUTFILE "F90_MPI = mpif90\n";
     print OUTFILE "FLAGS_OPT = -O2\n";
     print OUTFILE "FLAGS_MSC = -W0 -assume byterecl -traceback -diag-disable 8290 -diag-disable 8291 -diag-disable 8293\n";
--- SdsBabanin.ftn90	2018-11-30 17:31:10.755334788 +0100
+++ SdsBabanin.ftn90	2018-11-30 17:16:16.000000000 +0100
@@ -25,7 +25,7 @@
     !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -327,7 +327,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -780,7 +780,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1266,7 +1266,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1410,7 +1410,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1604,7 +1604,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1719,7 +1719,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1898,7 +1898,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2056,7 +2056,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2213,7 +2213,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2609,7 +2609,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- serv_xnl4v5.ftn90	2018-11-30 17:31:10.755334788 +0100
+++ serv_xnl4v5.ftn90	2018-11-30 17:16:16.000000000 +0100
@@ -54,7 +54,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -130,7 +130,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -341,7 +341,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -451,7 +451,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -520,7 +520,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -738,7 +738,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -808,7 +808,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanBndStruc.ftn90	2018-11-30 17:31:10.755334788 +0100
+++ SwanBndStruc.ftn90	2018-11-30 17:16:16.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanBpntlist.ftn90	2018-11-30 17:31:10.755334788 +0100
+++ SwanBpntlist.ftn90	2018-11-30 17:16:25.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanCheckGrid.ftn90	2018-11-30 17:31:10.755334788 +0100
+++ SwanCheckGrid.ftn90	2018-11-30 17:16:16.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swancom1.ftn	2018-11-30 17:31:10.755334788 +0100
+++ swancom1.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -79,7 +79,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2199,7 +2199,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3404,7 +3404,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3844,7 +3844,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4311,7 +4311,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4533,7 +4533,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4932,7 +4932,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5377,7 +5377,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5597,7 +5597,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5843,7 +5843,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6207,7 +6207,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7061,7 +7061,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7212,7 +7212,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7356,7 +7356,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7545,7 +7545,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8156,7 +8156,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8665,7 +8665,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8783,7 +8783,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -9144,7 +9144,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -9699,7 +9699,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swancom2.ftn	2018-11-30 17:31:10.759334780 +0100
+++ swancom2.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -49,7 +49,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -577,7 +577,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -888,7 +888,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1035,7 +1035,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1168,7 +1168,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1368,7 +1368,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1789,7 +1789,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2236,7 +2236,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2456,7 +2456,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2846,7 +2846,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swancom3.ftn	2018-11-30 17:31:10.759334780 +0100
+++ swancom3.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -53,7 +53,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -570,7 +570,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1150,7 +1150,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1383,7 +1383,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1563,7 +1563,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1866,7 +1866,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2105,7 +2105,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2664,7 +2664,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swancom4.ftn	2018-11-30 17:31:10.759334780 +0100
+++ swancom4.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -72,7 +72,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -514,7 +514,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -707,7 +707,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1205,7 +1205,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1607,7 +1607,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2001,7 +2001,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2407,7 +2407,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2695,7 +2695,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2824,7 +2824,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3028,7 +3028,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3167,7 +3167,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3516,7 +3516,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3895,7 +3895,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4239,7 +4239,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swancom5.ftn	2018-11-30 17:31:10.759334780 +0100
+++ swancom5.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -55,7 +55,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -262,7 +262,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -880,7 +880,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1165,7 +1165,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1784,7 +1784,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1957,7 +1957,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2266,7 +2266,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2600,7 +2600,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3097,7 +3097,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3417,7 +3417,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3809,7 +3809,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4094,7 +4094,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4347,7 +4347,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4664,7 +4664,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4895,7 +4895,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5194,7 +5194,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5504,7 +5504,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanCompdata.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanCompdata.ftn90	2018-11-30 17:16:17.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanCompUnstruc.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanCompUnstruc.ftn90	2018-11-30 17:16:25.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanComputeForce.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanComputeForce.ftn90	2018-11-30 17:16:17.000000000 +0100
@@ -12,7 +12,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanConvAccur.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanConvAccur.ftn90	2018-11-30 17:16:17.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanConvStopc.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanConvStopc.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanCreateEdges.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanCreateEdges.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanCrossObstacle.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanCrossObstacle.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanDiffPar.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanDiffPar.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanDispParm.ftn90	2018-11-30 17:31:10.759334780 +0100
+++ SwanDispParm.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanFindObstacles.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanFindObstacles.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanFindPoint.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanFindPoint.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGradDepthorK.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGradDepthorK.ftn90	2018-11-30 17:16:18.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGradVel.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGradVel.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGridCell.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGridCell.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGriddata.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGriddata.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGridFace.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGridFace.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGridobjects.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGridobjects.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGridTopology.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGridTopology.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGridVert.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGridVert.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanGSECorr.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanGSECorr.ftn90	2018-11-30 17:16:19.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanhcat.ftn	2018-11-30 17:31:10.763334772 +0100
+++ swanhcat.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -16,7 +16,7 @@
 !     hcat.nml file.
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanInitCompGrid.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanInitCompGrid.ftn90	2018-11-30 17:16:20.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanInterpolateAc.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanInterpolateAc.ftn90	2018-11-30 17:16:20.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanInterpolateOutput.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanInterpolateOutput.ftn90	2018-11-30 17:16:20.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanInterpolatePoint.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanInterpolatePoint.ftn90	2018-11-30 17:16:20.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanIntgratSpc.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanIntgratSpc.ftn90	2018-11-30 17:16:20.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanmain.ftn	2018-11-30 17:31:10.763334772 +0100
+++ swanmain.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -49,7 +49,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -186,7 +186,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1008,7 +1008,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1170,7 +1170,7 @@
       VERNUM = 41.20
       WRITE (VERTXT, '(F5.2)') VERNUM                                     40.03
       CALL BUGFIX ('A')
-!      CALL BUGFIX ('B')
+      CALL BUGFIX ('B')
 !
       CALL OCPINI ('swaninit', .TRUE.,INERR)                              34.01
       IF (INERR.GT.0) RETURN                                              34.01
@@ -3591,7 +3591,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4018,7 +4018,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4407,7 +4407,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4928,7 +4928,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5331,7 +5331,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5460,7 +5460,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5590,7 +5590,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5765,7 +5765,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5864,7 +5864,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6235,7 +6235,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6857,7 +6857,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7477,7 +7477,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7919,7 +7919,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8302,7 +8302,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -8599,7 +8599,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanMaxOverNodes.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanMaxOverNodes.ftn90	2018-11-30 17:16:20.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanMinOverNodes.ftn90	2018-11-30 17:31:10.763334772 +0100
+++ SwanMinOverNodes.ftn90	2018-11-30 17:16:20.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanout1.ftn	2018-11-30 17:31:10.767334763 +0100
+++ swanout1.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -48,7 +48,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -499,7 +499,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -857,7 +857,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1126,7 +1126,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1456,7 +1456,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2687,7 +2687,6 @@
 !PUN            ENDIF
 !PUN            IF ( IONOD(IP).EQ.MYPROC ) WRITE(NREF) IP, IVERTP
 !PUN         ENDDO
-!PUN         IF (IRQ.EQ.NREOQ) CLOSE(NREF)
 !PUN      ENDIF
 !
  900  IF (ALLOCATED(KVERT)) DEALLOCATE(KVERT)                             41.07
@@ -2717,7 +2716,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2982,7 +2981,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4623,7 +4622,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4843,7 +4842,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanout2.ftn	2018-11-30 17:31:10.767334763 +0100
+++ swanout2.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -40,7 +40,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -215,7 +215,7 @@
            WRITE(NREF,'(A31,A20)') '        hs     tp     lp       ',
      &                             'theta     sp      wf'
         END IF
-!NCF      ELSE IF (NCF .AND. NREF.EQ.0) THEN                                  41.40
+!NCF      ELSE IF (NCF .AND. NCOFFSET(IRQ).EQ.0) THEN                         41.40
 !NCF        ! reserve free unit number
 !NCF        IOSTAT = -1
 !NCF        INQUIRE(FILE=FILENM, EXIST=EXIST)                                 41.43
@@ -382,7 +382,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -609,7 +609,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -757,7 +757,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -956,7 +956,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1379,7 +1379,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1503,7 +1503,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1639,10 +1639,10 @@
 !NCF     &      INDEX (FILENM, '.nc' ).NE.0                                   41.40
 !NCF!
 !NCF      IF ( NCF ) THEN                                                     41.40
+!NCF         ! When PARALLEL, write intermediate binary files
 !NCF         CALL swn_outnc_spec ( RTYPE, OQI, OQR, MIP, VOQR,
 !NCF     &                         VOQ, AC2, SPCSIG, SPCDIR,
 !NCF     &                         DEP2, KGRPNT, CROSS, IONOD )
-!NCF         IF (STPNOW()) RETURN
 !NCF         RETURN
 !NCF      ENDIF
 !NCF!
@@ -1869,7 +1869,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2203,7 +2203,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2501,7 +2501,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanparll.ftn	2018-11-30 17:31:10.767334763 +0100
+++ swanparll.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -52,7 +52,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -236,7 +236,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -361,7 +361,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -489,7 +489,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -626,7 +626,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -769,7 +769,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -905,7 +905,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1100,7 +1100,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1217,7 +1217,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1357,7 +1357,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1495,7 +1495,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1698,7 +1698,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1936,7 +1936,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2205,7 +2205,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2376,7 +2376,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2722,7 +2722,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2889,7 +2889,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3121,7 +3121,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3311,7 +3311,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3477,7 +3477,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3644,7 +3644,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3931,7 +3931,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4236,8 +4236,6 @@
 !PUN     &                                'file output.set does not exist' )
 !PUN                           RETURN
 !PUN                        ENDIF
-!PUN                     ELSE
-!PUN                        IF ( IRQ.EQ.1 ) REWIND(IUNIT)
 !PUN                     ENDIF
 !PUN                     READ(IUNIT) ITMP1, ITMP2
 !PUN                     IF (ITMP1.EQ.IRQ) THEN
@@ -4365,7 +4363,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4710,7 +4708,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4849,7 +4847,6 @@
 !NCF!
 !NCF      IF ( NCF ) THEN                                                     41.40
 !NCF         CALL swn_outnc_colspc( RTYPE, OQI, OQR, MIP, KGRPGL )
-!NCF         IF (STPNOW()) RETURN
 !NCF         RETURN
 !NCF      ENDIF
 !NCF
@@ -5086,7 +5083,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5569,7 +5566,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanPointinMesh.ftn90	2018-11-30 17:31:10.767334763 +0100
+++ SwanPointinMesh.ftn90	2018-11-30 17:16:21.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanpre1.ftn	2018-11-30 17:31:10.767334763 +0100
+++ swanpre1.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -52,7 +52,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2985,7 +2985,7 @@
 ! ============================================================
 !
       IF (KEYWIS ('TRI')) THEN
-        CALL ININTG ('ITRIAD', ITRIAD, 'STA', 1)
+        CALL ININTG ('ITRIAD', ITRIAD, 'STA', 11)
         IF (ITRIAD.EQ.1) THEN
            CALL INREAL ('TRFAC', PTRIAD(1), 'STA', 0.8)                   41.44
            CALL INREAL ('CUTFR', PTRIAD(2), 'STA', 2.5)                   40.61 40.56 30.82
@@ -3114,7 +3114,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3549,7 +3549,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4062,7 +4062,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4229,7 +4229,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4505,7 +4505,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4720,7 +4720,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5085,7 +5085,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5195,7 +5195,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5367,7 +5367,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5538,7 +5538,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6137,7 +6137,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanpre2.ftn	2018-11-30 17:31:10.767334763 +0100
+++ swanpre2.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -36,7 +36,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -202,7 +202,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1043,7 +1043,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1976,7 +1976,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2146,7 +2146,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2264,7 +2264,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2396,7 +2396,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3635,7 +3635,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4126,7 +4126,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4716,7 +4716,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5237,7 +5237,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5610,7 +5610,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5774,7 +5774,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanPrepComp.ftn90	2018-11-30 17:31:10.767334763 +0100
+++ SwanPrepComp.ftn90	2018-11-30 17:16:21.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanPrintGridInfo.ftn90	2018-11-30 17:31:10.767334763 +0100
+++ SwanPrintGridInfo.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanPropvelS.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanPropvelS.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -17,7 +17,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanPropvelX.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanPropvelX.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanPunCollect.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanPunCollect.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanReadADCGrid.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanReadADCGrid.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -54,7 +54,7 @@
 !
 !   Modules used
 !
-!PUN    use ocpcomm2
+    use ocpcomm2
     use ocpcomm4
     use m_genarr
     use SwanGriddata
@@ -65,7 +65,7 @@
 !
 !   Local variables
 !
-    character(80)           :: grdfil   ! name of grid file including path
+    character(lenfnm)       :: grdfil   ! name of grid file including path
     integer, save           :: ient = 0 ! number of entries in this subroutine
     integer                 :: idum     ! dummy integer
     integer                 :: ii       ! auxiliary integer
--- SwanReadEasymeshGrid.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanReadEasymeshGrid.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanReadfort18.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanReadfort18.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -69,7 +69,7 @@
 !PUN    integer                 :: iostat   ! I/O status in call FOR
 !PUN    integer                 :: istat    ! indicate status of allocation
 !PUN    integer                 :: j        ! loop counter
-!PUN    character(80)           :: msgfil   ! name of message-passing file including path
+!PUN    character(lenfnm)       :: msgfil   ! name of message-passing file including path
 !PUN    integer                 :: ndsd     ! unit reference number of file
 !PUN    logical                 :: stpnow   ! indicate whether program must be terminated or not
 !PUN!
--- SwanReadGrid.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanReadGrid.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanReadTriangleGrid.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanReadTriangleGrid.ftn90	2018-11-30 17:16:22.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swanser.ftn	2018-11-30 17:31:10.771334754 +0100
+++ swanser.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -70,7 +70,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -204,7 +204,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -331,7 +331,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -430,7 +430,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -584,7 +584,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -759,7 +759,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -927,7 +927,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1064,7 +1064,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1135,7 +1135,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1365,7 +1365,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1706,7 +1706,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1894,7 +1894,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2109,7 +2109,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2261,7 +2261,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2383,7 +2383,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2599,7 +2599,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2798,7 +2798,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3015,7 +3015,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3301,7 +3301,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -3827,7 +3827,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4175,7 +4175,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -4607,7 +4607,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5009,7 +5009,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5134,7 +5134,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5232,7 +5232,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5332,7 +5332,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5520,7 +5520,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5826,7 +5826,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -5962,7 +5962,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6078,7 +6078,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6247,7 +6247,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6410,7 +6410,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6775,7 +6775,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6877,7 +6877,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -6969,7 +6969,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7051,7 +7051,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7166,7 +7166,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7281,7 +7281,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -7422,7 +7422,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanSpectPart.ftn	2018-11-30 17:31:10.771334754 +0100
+++ SwanSpectPart.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -24,7 +24,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -139,7 +139,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -249,7 +249,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -502,7 +502,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -642,7 +642,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -876,7 +876,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1224,7 +1224,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanSumOverNodes.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanSumOverNodes.ftn90	2018-11-30 17:16:23.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanSweepSel.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanSweepSel.ftn90	2018-11-30 17:16:23.000000000 +0100
@@ -14,7 +14,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanThreadBounds.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanThreadBounds.ftn90	2018-11-30 17:16:23.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanTranspAc.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanTranspAc.ftn90	2018-11-30 17:16:23.000000000 +0100
@@ -16,7 +16,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanTranspX.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanTranspX.ftn90	2018-11-30 17:16:23.000000000 +0100
@@ -13,7 +13,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- SwanVertlist.ftn90	2018-11-30 17:31:10.771334754 +0100
+++ SwanVertlist.ftn90	2018-11-30 17:16:23.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swmod1.ftn	2018-11-30 17:31:10.771334754 +0100
+++ swmod1.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -26,7 +26,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -184,7 +184,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -306,7 +306,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -409,7 +409,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -552,7 +552,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1436,7 +1436,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1646,7 +1646,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2578,7 +2578,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -2732,7 +2732,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swmod2.ftn	2018-11-30 17:31:10.771334754 +0100
+++ swmod2.ftn	2018-11-30 17:16:25.000000000 +0100
@@ -25,7 +25,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -148,7 +148,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -291,7 +291,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -393,7 +393,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -538,7 +538,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -653,7 +653,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -801,7 +801,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1002,7 +1002,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
--- swn_outnc.ftn90	2018-11-30 17:31:10.775334746 +0100
+++ swn_outnc.ftn90	2018-11-30 17:16:24.000000000 +0100
@@ -11,7 +11,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -81,6 +81,7 @@
                                    skip_range_error = .true.
     type(recordaxe_type), save  :: recordaxe(MAX_OUTP_REQ)
     integer,save                :: ncoffset(MAX_OUTP_REQ) = 0
+    logical,save                :: read_header(MAX_OUTP_REQ) = .true.
 
 !PUN    logical                     :: PUNSWAN = .true.
 !NPUN    logical                     :: PUNSWAN = .false.
@@ -113,7 +114,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -238,7 +239,7 @@
         if (STPNOW()) return
 
         call nccheck(nf90_close(oqi(1) + ncoffset(irq) ))
-        oqi(1) = 0
+        ncoffset(irq) = 0
       end if
 
       call swn_outnc_deallocate_spcaux( spcaux )
@@ -262,7 +263,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -281,10 +282,10 @@
 !
 !
 !  0. Authors
-!
+!     41.70 A.Th.C. Hulst
 !
 !  1. Updates
-!
+!     41.70 Added support for multiple compute commands and multiple specout requests
 !
 !  2. Purpose
 !
@@ -308,7 +309,7 @@
 !
 !  5. Local variables
 !
-      logical                             :: lopen, read_header, file_exists, &
+      logical                             :: lopen, file_exists, &
                                              EQREAL, STPNOW
       integer                             :: ip, ierr, otype, xpctime2, &
                                              i, tmip, binnr, irq, &
@@ -398,9 +399,6 @@
                     call MSGERR(4, errmsg)
                     return
                 end if
-                read_header = .true.
-            else
-                read_header = .false.
             end if
             inquire(unit=binnr, opened=lopen)
             if ( .not. lopen ) then
@@ -411,7 +409,8 @@
 
             ! In the final collocation the spatial, spectral and directional grids are unknown.
             ! They are exchanged via the binary file of the master process.
-            if ( read_header .and. iproc == 1 ) then
+            if ( read_header(irq) .and. iproc == 1 ) then
+                read_header(irq) = .false.
                 read(binnr, IOSTAT=ierr) spcaux%xp
                 if ( ierr /= 0 ) then
                   write(errmsg,'("Reading grid data from ", A, " returned IOSTAT ", I3.3)') trim(binfile), ierr
@@ -431,7 +430,7 @@
 
             read(binnr, IOSTAT=ierr) xpctime2, tmip
             if ( ierr /= 0 ) then
-                write(errmsg,'("Reading time and tmip from ", A, "(",I3,") , time ", A, ", returned IOSTAT ", I3.3)') &
+                write(errmsg,'("Reading time and tmip from ", A, "(",I3,") , time ", A, ", returned IOSTAT ", I3)') &
                      trim(binfile), binnr, CHTIME, ierr
                 call MSGERR(4, errmsg)
                 return
@@ -467,9 +466,10 @@
 !PUN         ilpos   = len(trim(LOCALDIR))+2
 !PUN         ncfile = ncfile(ilpos:LENFNM)
 !PUN         ncfile = trim(GLOBALDIR)//DIRCH2//trim(ncfile)
-
-        call swn_outnc_openspecfile(ncfile, spcaux, OQI, OQR)
-        if (STPNOW()) return
+        if ( ncoffset(irq) == 0 ) then
+            call swn_outnc_openspecfile(ncfile, spcaux, OQI, OQR)
+            if (STPNOW()) return
+        end if
 
         call swn_outnc_appendspc(OQI, spcaux, xpctime2)
         if (STPNOW()) return
@@ -477,8 +477,10 @@
         call swn_outnc_deallocate_spcaux( spcaux )
 
         if ( NSTATM == 0 .or. TIMCO >= TFINC ) then
+            ! The end time is reached in each computation block. See
+            ! SWCOLOUT structure.
             call close_ncfile(OQI(1) + ncoffset(irq) )
-            OQI(1) = 0
+            ncoffset(irq) = 0
 
             ! The intermediate binary files are closed and deleted in
             !    swanparll.ftn -> SWCOLOUT
@@ -507,7 +509,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -526,10 +528,10 @@
 !
 !
 !  0. Authors
-!
+!     41.70 Sander Hulst
 !
 !  1. Updates
-!
+!     41.70 Do not close binary files. Breaks on multiple compute commands
 !
 !  2. Purpose
 !
@@ -781,20 +783,6 @@
         end if
       end do
 
-      if ( PARLL .or. PUNSWAN ) then
-        ! in parallel mode, close binary file when required
-        if (NSTATM == 0 .or. TIMCO >= TFINC) then
-          inquire(unit=OQI(1), opened=lopen)
-          if ( lopen ) then
-            close(unit=OQI(1))
-          else
-            write(errmsg, '("File ", A, " is already closed. This is a code error")') trim(OUTP_FILES(irq))
-            call MSGERR(4, errmsg)
-            return
-          end if
-        end if
-      end if
-
     end subroutine swn_outnc_spcaux
 
     subroutine swn_outnc_spcaux_on_wetnodes( lkgrpnt, lspcaux, spcaux )
@@ -899,7 +887,7 @@
 !
 !
 !     SWAN (Simulating WAves Nearshore); a third generation wave model
-!     Copyright (C) 1993-2018  Delft University of Technology
+!     Copyright (C) 1993-2019  Delft University of Technology
 !
 !     This program is free software; you can redistribute it and/or
 !     modify it under the terms of the GNU General Public License as
@@ -1061,7 +1049,7 @@
             call agnc_add_pntdata(ncid, 'xwnd',  ri, pspcaux%wndx,  OVEXCV(26), skip_range_error)
             call agnc_add_pntdata(ncid, 'ywnd',  ri, pspcaux%wndy,  OVEXCV(26), skip_range_error)
         end if
-    end if
+      end if
 
       ! garbage collect
       nullify(pspcaux)
@@ -1426,8 +1414,8 @@
         ! increasing the chance on file corruption
         if (LTRACE) call STRACE (IENT,'swn_outnc_close_on_end')
         if ( nstatm == 0 .or. TIMCO >= TFINC ) then
+            ncoffset(irq) = 0
             call close_ncfile(ncid)
-            nref = 0
         else
             call nccheck( NF90_SYNC(ncid) )
         end if
