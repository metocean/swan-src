diff -r -u ftn_stockB/swn_outnc.ftn90 ftn_stockB-fix/swn_outnc.ftn90
--- ftn_stockB/swn_outnc.ftn90	2019-05-08 18:14:39.400497129 +1200
+++ ftn_stockB-fix/swn_outnc.ftn90	2019-05-08 18:43:29.021579188 +1200
@@ -1136,7 +1136,11 @@
                 READ (chtime, '(I8,1X,I6)') (xpctmp(i), i=1,2)
                 ! should be seconds since epoch.
                 recordaxe(irq)%content(1) = seconds_since_epoch(xpctmp(1), xpctmp(2))
-                recordaxe(irq)%delta      = maxval((/oqr(2), DT/))
+                if (DT == 1.E10) then
+                    recordaxe(irq)%delta = oqr(2)
+                else
+                    recordaxe(irq)%delta = maxval((/oqr(2), DT/))
+                end if
                 recordaxe(irq)%nstatm     = .true.
             else
                 ! stationary, record axe is "run"
@@ -1300,7 +1304,11 @@
         ! if only only record found, set delta to delta specified in command file (or 1 on stationary)
         if ( recordaxe(irq)%ncontent == 1 ) then
             if ( NSTATM > 0 ) then
-                recordaxe(irq)%delta = maxval((/oqr(2), DT/))
+                if (DT == 1.E10) then
+                    recordaxe(irq)%delta = oqr(2)
+                else
+                    recordaxe(irq)%delta = maxval((/oqr(2), DT/))
+                end if
             else
                 recordaxe(irq)%delta = 1
             end if
@@ -1496,7 +1504,11 @@
                 READ (chtime, '(I8,1X,I6)') (xpctmp(i), i=1,2)
                 ! should be seconds since epoch. This is probably not it.
                 recordaxe(irq)%content(1) = seconds_since_epoch(xpctmp(1), xpctmp(2))
-                recordaxe(irq)%delta      = maxval((/oqr(2), DT/))
+                if (DT == 1.E10) then
+                    recordaxe(irq)%delta = oqr(2)
+                else
+                    recordaxe(irq)%delta = maxval((/oqr(2), DT/))
+                end if
                 recordaxe(irq)%nstatm     = .true.
             else
                 ! stationary, record axe is "run"
@@ -1595,7 +1607,11 @@
         ! if only only record found, set delta to delta specified in command file (or 1 on stationary)
         if ( recordaxe(irq)%ncontent == 1 ) then
             if ( NSTATM > 0 ) then
-                recordaxe(irq)%delta = maxval((/oqr(2), DT/))
+                if (DT == 1.E10) then
+                    recordaxe(irq)%delta = oqr(2)
+                else
+                    recordaxe(irq)%delta = maxval((/oqr(2), DT/))
+                end if
             else
                 recordaxe(irq)%delta = 1
             end if
