#!/bin/bash

# create new branch for src update
SWAN_VERSION=4145
git checkout -b "version_update_$SWAN_VERSION"

BASEDIR=/source/swan-src/swan_src

mkdir $BASEDIR/ftn_new
cd $BASEDIR/ftn_new
echo "Downloading swan version $SWAN_VERSION"
wget https://swanmodel.sourceforge.io/download/zip/swan$SWAN_VERSION.tar.gz
tar xpfz swan$SWAN_VERSION.tar.gz
mv swan$SWAN_VERSION/* .
rm -rf swan$SWAN_VERSION*

echo
echo "Getting individual patch of the following modified MSL files:"
bash $BASEDIR/patch/create_patch_files.sh

echo
echo "Replacing ftn_msl with new files from ftn_new"
cp -a $BASEDIR/ftn_msl $BASEDIR/ftn_msl_old # save old msl for tmp backup
rm -rf $BASEDIR/ftn_msl/*
for f in $(ls $BASEDIR/ftn_new/*); do
    fname=$(basename $f)
    cp $BASEDIR/ftn_new/$fname $BASEDIR/ftn_msl/$fname
done
# reset macro to nvidia (current compiler used - this can be an env variable)
cp -a $BASEDIR/ftn_msl_old/macros/ $BASEDIR/ftn_msl/ # readd macros options
rm $BASEDIR/ftn_msl/macros.inc
ln -s $BASEDIR/ftn_msl/macros/nvidia_static_macros.inc $BASEDIR/ftn_msl/macros.inc

echo
echo "Applying patch of MSL vs previous stock to new files"
# WARNING: this will usually fail for swanmain.ftn if new vars are added in the official release
for f in $(ls $BASEDIR/patch/*ftn*.patch); do
    fname=$(basename $f)
    patch -p0 -u $BASEDIR/ftn_msl/${fname%.*} $BASEDIR/patch/$fname
done

# # NOTE: after the above step it might be necessary to fix patch conflixts
# # that's why we do not remove/cleanup any directories. Otherwise:
# echo
# echo "Cleaning up"
# rm -rf $BASEDIR/ftn_stock
# mv $BASEDIR/ftn_new $BASEDIR/ftn_stock
# rm -rf $BASEDIR/ftn_msl_old
# # recopy macros options to stock and link as it is also used
# mkdir $BASEDIR/ftn_stock/macros
# cp $BASEDIR/ftn_msl/macros/gfortran_static_macros.inc $BASEDIR/ftn_stock/macros/macros.inc
# cp $BASEDIR/ftn_msl/macros/nvidia_static_macros.inc $BASEDIR/ftn_stock/macros/
# rm $BASEDIR/ftn_stock/macros.inc
# ln -s $BASEDIR/ftn_stock/macros/nvidia_static_macros.inc $BASEDIR/ftn_stock/macros.inc
# # for the latest versions, 41.41 and 41.45, after fixing swanmain.ftn we also cleanup:
# rm $BASEDIR/ftn_msl/*.ftn.orig
# rm $BASEDIR/ftn_msl/swanmain.ftn.rej

echo
git status
echo "Finished."