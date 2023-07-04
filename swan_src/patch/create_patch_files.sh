#!/bin/bash

BASEDIR=/source/swan-src/swan_src

stock_dir=$BASEDIR/ftn_stock
msl_dir=$BASEDIR/ftn_msl
diff_dir=$BASEDIR/patch

## -------- Generate patch files for all modified files:
files=("agioncmd.ftn90" "nctablemd.ftn90" "ocpids.ftn" "swanmain.ftn" "swanout1.ftn" \
       "SwanSpectPart.ftn" "swmod1.ftn" "swn_outnc.ftn90")
for f in ${files[@]}; do
  echo "Creating patch for file $f"
  diff -u -Z -B -p15 $stock_dir/$f $msl_dir/$f > ${diff_dir}/${f}.patch.2
done
