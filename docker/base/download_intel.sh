#!/bin/bash

# host="kina1.rag.metocean.co.nz"
host="papahu.rag.metocean.co.nz"

rsync -avz -e "ssh -o StrictHostKeyChecking=no" \
    --exclude 'composer_xe_2013.0.079/Samples' \
    --exclude 'composer_xe_2013.0.079/Documentation' \
    --exclude 'composer_xe_2013.0.079/eclipse_support' \
    --exclude 'composer_xe_2013.0.079/mkl' \
    --exclude 'composer_xe_2013.0.079/ipp' \
    --exclude 'composer_xe_2013.0.079/tbb' \
    --exclude 'composer_xe_2013.0.079/debugger' \
    --exclude 'composer_xe_2013.0.079/bin/sourcechecker' \
    --exclude 'bin/intel64_mic' \
    --exclude 'composer_xe_2013.0.079/bin/ia32' \
    --exclude 'composer_xe_2013.0.079/compiler/include/ia32' \
    --exclude 'er_xe_2013.0.079/compiler/lib/ia32' \
    --exclude 'composer_xe_2013.0.079/bin/sourcechecker/bin/ia32' \
    --exclude 'composer_xe_2013.0.079/bin/sourcechecker/lib/ia32' \
    --exclude 'composer_xe_2013.0.079/mpirt/bin/ia32' \
    --exclude 'composer_xe_2013.0.079/mpirt/lib/ia32' \
    --exclude 'ism/bin/ia32' \
    --exclude 'ism/lib/ia32' \
    --exclude 'composer_xe_2013.0.079/compiler/include/mic' \
    --exclude 'composer_xe_2013.0.079/compiler/lib/mic' \
    rafael@$host:/opt/intel/ /opt/intel
    # metocean@$host:/opt/intel/ /opt/intel