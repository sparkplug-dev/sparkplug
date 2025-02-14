#!/bin/bash

CONTAINER_NAME=yoctobuilder

# Launch a crops/poky docker instance with the arguments as commands
docker run --rm -it -v ${PWD}:/workdir ${CONTAINER_NAME} --workdir=/workdir $@
