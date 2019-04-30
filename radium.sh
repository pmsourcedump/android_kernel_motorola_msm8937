#!/bin/bash

# These export unneeded variables
export DEFCONFIG="montana_defconfig"

# Export User & Host
export KBUILD_BUILD_USER=JARLPENGUIN
export KBUILD_BUILD_HOST=RADIUM

# This exports toolchain location
echo "**** Setting Toolchain ****"
cd ../toolchain
export CROSS_COMPILE=$(pwd)/bin/aarch64-linux-android-
export ARCH=arm64 && export SUBARCH=arm64
cd ../kernel
# Sync from source
git pull
# This spits out words
echo "**** Kernel defconfig is set to $DEFCONFIG ****"
# This makes a clean build
echo "**** Cleaning... ***"
rm -rf out
mkdir -p out
# This builds the kernel
echo "**** Building... ***"
make montana_defconfig && make -j$(nproc --all)
# This packages the kernel
echo -e "**** Packaging.... ****"
cp out/arch/arm64/boot/Image.gz ../AnyKernel2Template
cd ../AnyKernel2Template
echo "Building RADIUM  Kernel for montana!"
# This zips the kernel up
rm -rf kernel.zip
zip -r9 kernel.zip * -x README.md kernel.zip

echo "Done. Check ~/AnyKernel2Template for the kernel zip to flash."
