#!/bin/bash

set -e

# create new branch for src update
git checkout -b "version_update"

BASEDIR=/source/swan-src/swan_src

SWAN_VERSION=4145
mkdir $BASEDIR/ftn_new
cd $BASEDIR/ftn_new
echo "Downloading swan version $SWAN_VERSION"
wget https://swanmodel.sourceforge.io/download/zip/swan$SWAN_VERSION.tar.gz
tar xpfz swan$SWAN_VERSION.tar.gz
mv swan$SWAN_VERSION/* .
rm -rf swan$SWAN_VERSION*

echo
echo "Getting individual patch of the following modified MSL files:"
bash /source/swan-src/swan_src/patch/create_patch_files.sh

echo
echo "Replacing ftn_msl with new files from ftn_new"
rm -rf /source/swan-src/swan_src/ftn_msl/*.ftn*
for f in $(ls /source/swan-src/swan_src/ftn_new/*.ftn*); do
    fname=$(basename $f)
    cp /source/swan-src/swan_src/ftn_new/$fname /source/swan-src/swan_src/ftn_msl/$fname
done

echo
echo "Applying patch of MSL vs previous stock to new files"
# WARNING: this will usually fail for swanmain.ftn if new vars are added in the official release
for f in $(ls /source/swan-src/swan_src/patch/*ftn*.patch); do
    fname=$(basename $f)
    patch -p0 -u /source/swan-src/swan_src/ftn_msl/${fname%.*} /source/swan-src/swan_src/patch/$fname
done

echo
git status
echo "Finished."