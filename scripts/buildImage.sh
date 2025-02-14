#!/bin/bash

# This script will be execute in the build docker
# The build folder should already be set up with the appropriate configuration
# before running this script

WORK_DIR=${PWD}
BUILD_DIR=${WORK_DIR}/build

# Set up build tools environment
source poky/oe-init-build-env ${BUILD_DIR}

# Execute the build of the image provided as an argument
# If no image was provided return an error 
if [ -z "$1" ]; then 
    echo "ERROR: No image was provided to './scripts/buildImage.sh'"
    exit 1
fi

# Execute the build
bitbake $1

RET_VALUE=$?
if [ $RET_VALUE -ne 0 ]; then
    echo "ERROR: bitbake build failed ('./scripts/buildImage.sh')"
    exit 2
fi

# Extract the image in the out-images folder
if [ -d "${BUILD_DIR}/tmp/deploy/images" ]; then
    cd ${BUILD_DIR}/tmp/deploy/images
    cd *

    if [ ! -d "${BUILD_DIR}/out-images" ]; then
        mkdir ${BUILD_DIR}/out-images
    fi

    cp $1-*rootfs.wic.bz2 ${BUILD_DIR}/out-images/root.img.bz2
    cd ${BUILD_DIR}/out-images

    bzip2 -fd root.img.bz2 
else 
    echo "ERROR: No output image found ('./scripts/buildImage.sh')"
    exit 3
fi
