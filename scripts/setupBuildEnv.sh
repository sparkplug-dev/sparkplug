#!/bin/bash

# This script will be run from withing the build docker to setup
# the SparkPlug build environment

# The container working directory
WORK_DIR=${PWD}
BUILD_DIR=${WORK_DIR}/build

# Target machine for the build process return error
if [ -z "$1" ]; then
    echo "No build target was provided to 'scripts/setupBuildEnv.sh'"
    exit 1
fi

BUILD_CONFIG=$1

# If the build directory already exist delete the content of 
# the config folder to allow the template to overwrite it 
if [ -d "${WORK_DIR}/build/conf" ]; then
    rm -r ${WORK_DIR}/build/conf
fi

# Setup the build environment by running the oe-init-build-env script
export TEMPLATECONF=${WORK_DIR}/meta-sparkplug/conf/templates/${BUILD_CONFIG}
. /${WORK_DIR}/poky/oe-init-build-env ${BUILD_DIR}
