ls
cd build/
cd tmp/deploy/images/raspberrypi4-64/
ls
cd ..
cd *
less core-image-minimal-*.wic.bz2
bzip2 -d $1-*.wic.bz2
bzip2 -d core-image-minimal-*.wic.bz2
ls *.wix
ls *.wic
ls | grep .wic
bzip2 -d core-image-minimal-raspberrypi4-64.wic.bz2 
ls -l | grep .wic
bzip2 -d core-image-minimal-raspberrypi4-64-20250207233025.rootfs.wic.bz2 
bzip2 -fd core-image-minimal-raspberrypi4-64-20250207233025.rootfs.wic.bz2 
ls -l | grep .wic
mkdir ~/work/build/out-images
exit
