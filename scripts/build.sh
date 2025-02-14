#!/bin/bash

# This script is executed on the host machine to handle the build of SparkPlug
# It take as an argument the target build configuration

BUILD_IMAGE=sparkplug-image-dev

# Target machine for the build process 
# default to qemu if no argument is provided
if [ -z "$1" ]; then
    BUILD_CONFIG="qemu"
else
    BUILD_CONFIG=$1
fi

# Setting up the build environment
echo "Setting up build environment for ${BUILD_CONFIG}"
./scripts/runDocker.sh /bin/bash ./scripts/setupBuildEnv.sh ${BUILD_CONFIG}

# Launch the build process in the docker
echo "Initiating build of ${BUILD_IMAGE}"
./scripts/runDocker.sh /bin/bash ./scripts/buildImage.sh ${BUILD_IMAGE}

