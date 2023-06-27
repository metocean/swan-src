#!/bin/bash
stock_dir="/source/swan-src/swan_src/ftn_stock/"
msl_dir="/source/swan-src/swan_src/ftn_msl/"
diff_dir="/source/swan-src/swan_src/patch/"

## -------- Generate patch files for all modified files:
files=("abc" "def")
files=("agioncmd.ftn90" "nctablemd.ftn90" "ocpids.ftn" "swanmain.ftn" "swanout1.ftn" \
       "SwanSpectPart.ftn" "swmod1.ftn" "swn_outnc.ftn90")
for f in ${files[@]}; do
  echo $f
  diff -u -Z -B -p15 ${stock_dir}${f} ${msl_dir}${f} > ${diff_dir}${f}.patch
  sed -i '1,2d' ${diff_dir}${f}.patch
done