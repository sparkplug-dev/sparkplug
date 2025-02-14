#!/bin/bash

# Build a Yocto build container 

CONTAINER_NAME=yoctobuilder

BASE_DISTRO=ubuntu-22.04

docker build -t ${CONTAINER_NAME} --build-arg BASE_DISTRO=${BASE_DISTRO} poky-container
