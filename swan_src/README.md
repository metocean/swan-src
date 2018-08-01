# Patching MSL changes into SWAN source code
Assumes source code is organised in the following structure:

```
|- swan-src
   |- swan_src
      |- ftn_stock
      |- ftn_msl
```

with the original and modified src code in `ftn_stock` and `ftn_msl` respectively.

The changes in MSL SWAN version currently include:

- Additional integrated output quantities.
- Changes to NetCDF output to include variables and conform with CF and MSL standards.
- Changes to allow specifying cmd file name when running model binary.

The changes can be implemented in new SWAN releases by following the steps below:

## Create a branch for the new release

- Replace both `ftn_stock` and `ftn_msl` with the original src code from the new release.
- Apply any available SWAN patches to both.

## Create MSL patch from previous version of source code

```
git checkout {PREVIOUS-SRC-VERSION}
cd /source/swan-src/swan_src
diff -Naur ftn_stock ftn_msl > patch.txt
```

## Apply MSL patch into current version of source code

```
git checkout {CURRENT-SRC-VERSION}
patch -p0 < patch.txt
```

## Manually fix rejected files *.rej
