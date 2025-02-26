#!/bin/bash

# This script will be execute in the build docker
# The build folder should already be set up with the appropriate configuration
# before running this script

WORK_DIR=${PWD}
BUILD_DIR=${WORK_DIR}/build

OUTPUT_IMG_NAME=root.img

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
    # Create the output image folder
    if [ ! -d "${BUILD_DIR}/out-images" ]; then
        mkdir ${BUILD_DIR}/out-images
    fi

    # Enter the most recently modified folder
    cd ${BUILD_DIR}/tmp/deploy/images
    cd $(ls -rt | tail -n 1)

    # Find the image file
    IMG=$(ls -rt | grep "${1}-${PWD##*/}.rootfs-.*.wic.bz2" | tail -n 1)

    if [ ! -z "${IMG}" ]; then
        cp  ${IMG} ${BUILD_DIR}/out-images/${OUTPUT_IMG_NAME}.bz2
    else
        echo "ERROR: No output image found ('./scripts/buildImage.sh')"
        exit 3
    fi


    # Decompress the image
    cd ${BUILD_DIR}/out-images

    # Store the pre decompression size
    COMP_SIZE=$(du -h ${OUTPUT_IMG_NAME}.bz2 | cut -f 1)

    echo "Decompressing the image"
    bzip2 -fd ${OUTPUT_IMG_NAME}.bz2 

    DECOMP_SIZE=$(du -h ${OUTPUT_IMG_NAME} | cut -f 1)

    echo "Build completed, output stored in '${BUILD_DIR}/${OUTPUT_IMG_NAME}'"

    echo "Compressed image size: ${COMP_SIZE}"
    echo "Decompressed image size: ${DECOMP_SIZE}"
else 
    echo "ERROR: No output image found ('./scripts/buildImage.sh')"
    exit 3
fi
