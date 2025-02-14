SUMMARY = "Transform your Raspberry Pi into a car head unit"
LICENSE = "GPL-3.0-only"

IMAGE_FEATURES += "read-only-rootfs splash weston"

IMAGE_INSTALL:append = "psplash"

IMAGE_OVERHEAD_FACTOR ?= "1.2"
IMAGE_ROOTFS_SIZE ?= "512000"

inherit core-image
