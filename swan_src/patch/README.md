# Known bugs and patches

For SWAN 41.10, patches are available here (if appropriate). These fix bugs. Also, new features will be released from time to time.
To apply a patch, first, you must place the downloaded patch files (right-clicking the file, open a new window and then save it as text file) in the folder where the source code of SWAN is located, and then execute the following command:

```
patch -p0 < patchfile
```

It is important not to change or modify the patch files since they may contain tabs! If needed, use dos2unix to convert DOS to UNIX format. After applying a patch, you need to recompile the SWAN source code.

## Changes
| ID | description of problem and fix or new features | release date | patchfile |
| -- | ---------------------------------------------- | ------------ | --------- |
| A | use double precision for time coding | 23-03-2017 | [41.10.A](http://swanmodel.sourceforge.net/problems_and_fixes/patches/41.10.A) |
| A | some automatic arrays used for SPB triads are made allocatable | 23-03-2017 | [41.10.A](http://swanmodel.sourceforge.net/problems_and_fixes/patches/41.10.A) |
| A | default CFL for refraction limiter changed from 0.5 to 0.9 | 23-03-2017 | [41.10.A](http://swanmodel.sourceforge.net/problems_and_fixes/patches/41.10.A) |
| A | support gfortran and Intel Fortran compilers for macOS | 23-03-2017 | [41.10.A](http://swanmodel.sourceforge.net/problems_and_fixes/patches/41.10.A) |
| A | support Intel Fortran compiler 17 for MS Windows | 23-03-2017 | [41.10.A](http://swanmodel.sourceforge.net/problems_and_fixes/patches/41.10.A) |

## Bug fixes
| ID | description of problem and fix or new features | release date | patchfile |
| -- | ---------------------------------------------- | ------------ | --------- |
| A | small correction interpolation near obstacles with flexible mesh | 23-03-2017 | [41.10.A](http://swanmodel.sourceforge.net/problems_and_fixes/patches/41.10.A) |
| A | correction comparison grid orientation and wave direction with formatted hotfiles | 23-03-2017 | [41.10.A](http://swanmodel.sourceforge.net/problems_and_fixes/patches/41.10.A) |
