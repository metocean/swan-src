--- swn_outnc.ftn90
@@ -81,6 +81,7 @@
                                    skip_range_error = .true.
     type(recordaxe_type), save  :: recordaxe(MAX_OUTP_REQ)
     integer,save                :: ncoffset(MAX_OUTP_REQ) = 0
+    logical,save                :: read_header(MAX_OUTP_REQ) = .true.
@@ -238,7 +239,7 @@
         if (STPNOW()) return
 
         call nccheck(nf90_close(oqi(1) + ncoffset(irq) ))
-        oqi(1) = 0
+        ncoffset(irq) = 0
       end if
 
       call swn_outnc_deallocate_spcaux( spcaux )
@@ -308,7 +309,7 @@
 !
-      logical                             :: lopen, read_header, file_exists, &
+      logical                             :: lopen, file_exists, &
                                              EQREAL, STPNOW
@@ -398,9 +399,6 @@
                 end if
-                read_header = .true.
-            else
-                read_header = .false.
             end if
@@ -411,7 +409,8 @@
             ! They are exchanged via the binary file of the master process.
-            if ( read_header .and. iproc == 1 ) then
+            if ( read_header(irq) .and. iproc == 1 ) then
+                read_header(irq) = .false.
                 read(binnr, IOSTAT=ierr) spcaux%xp
@@ -431,7 +430,7 @@
             if ( ierr /= 0 ) then
-                write(errmsg,'("Reading time and tmip from ", A, "(",I3,") , time ", A, ", returned IOSTAT ", I3.3)') &
+                write(errmsg,'("Reading time and tmip from ", A, "(",I3,") , time ", A, ", returned IOSTAT ", I3)') &
                      trim(binfile), binnr, CHTIME, ierr
@@ -467,9 +466,10 @@
 !PUN         ncfile = trim(GLOBALDIR)//DIRCH2//trim(ncfile)
-
-        call swn_outnc_openspecfile(ncfile, spcaux, OQI, OQR)
-        if (STPNOW()) return
+        if ( ncoffset(irq) == 0 ) then
+            call swn_outnc_openspecfile(ncfile, spcaux, OQI, OQR)
+            if (STPNOW()) return
+        end if
 
         call swn_outnc_appendspc(OQI, spcaux, xpctime2)
@@ -477,8 +477,10 @@
         if ( NSTATM == 0 .or. TIMCO >= TFINC ) then
+            ! The end time is reached in each computation block. See
+            ! SWCOLOUT structure.
             call close_ncfile(OQI(1) + ncoffset(irq) )
-            OQI(1) = 0
+            ncoffset(irq) = 0
 
             ! The intermediate binary files are closed and deleted in
@@ -781,20 +783,6 @@
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
@@ -1061,7 +1049,7 @@
         end if
-    end if
+      end if
 
       ! garbage collect
@@ -1426,8 +1414,8 @@
         if ( nstatm == 0 .or. TIMCO >= TFINC ) then
+            ncoffset(irq) = 0
             call close_ncfile(ncid)
-            nref = 0
         else
