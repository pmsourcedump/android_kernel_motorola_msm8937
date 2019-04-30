#!/bin/bash

## InfixRemix (solomonbooth63@gmail.com)

echo "Welcome to RADIUM"
# This prints ""
red='\033[0;31m'
# This sets the colour Red 
BUILD_START=$(date +"%s")
# This gets the time at the start of the build 
sudo apt update --quiet
# This gets updates for server/ci
sudo apt install --yes build-essential bc kernel-package libncurses5-dev bzip2 liblz4-tool git curl
# This gets the main Build packages if not already there
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 --single-branch toolchain
git clone https://github.com/infixremix/scripts scripts1

# These clone the Kernel and assets
export DIR=$(pwd)
export CROSS_COMPILE=$(pwd)/toolchain/bin/aarch64-linux-android-
export ARCH=arm64
export SUBARCH=arm64
export DEFCONFIG="montana_defconfig"
# Export User & Host

export KBUILD_BUILD_USER=JARLPENGUIN
export KBUILD_BUILD_HOST=RADIUM

# Clean build always lol
echo "**** Cleaning ****"
make clean && make mrproper

# The MAIN Part
echo "**** Setting Toolchain ****"
export ARCH=arm64
echo "**** Kernel defconfig is set to $DEFCONFIG ****"
mkdir -p out

make O=out clean

make O=out mrproper

make O=out montana_defconfig

make O=out -j$(nproc --all)
echo -e "red Radium kernel BUILT NOW PACKING"
mv out/arch/arm64/boot/Image.gz zImage
mv out/arch/arm64/boot/zImage /home/jarlpenguin/android_kernel_motorola_msm8937/scripts1/Ak2
cd scripts1
# This makes a directory for Builds
echo "Building RADIUM  Kernel for montana!"
# This prints ""
sudo chmod a+x zip.sh
. zip.sh

# This prints what is is in the builds dir
BUILD_END=$(date +"%s")
# Gets the current time
echo -e "$red RADIUM  Build Started At $BUILD_START and Finished at $BUILD_END"
# This prints "" in red

