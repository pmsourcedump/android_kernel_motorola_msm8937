#!/bin/bash

## InfixRemix (solomonbooth63@gmail.com)

echo "Welcome to RADIUM"
# This prints ""
red='\033[0;31m'
# This sets the colour Red 
BUILD_START=$(date +"%s")
# This gets the time at the start of the build 
sudo apt-get update --quiet
# This gets updates for server/ci
sudo apt-get install --yes build-essential bc kernel-package libncurses5-dev bzip2 liblz4-tool git curl
# This gets the main Build packages if not already there
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 --single-branch toolchain
git clone https://github.com/infixremix/scripts scripts1

# These clone the Kernel and assets
export DIR=$(pwd)

export CROSS_COMPILE=$(pwd)/toolchain/bin/aarch64-linux-android-
export ARCH=arm64
export SUBARCH=arm64
export DEFCONFIG="cedric_defconfig"
# Export User & Host

export KBUILD_BUILD_USER=INFIXREMIX
export KBUILD_BUILD_HOST=RADIUM

# Clean build always lol
echo "**** Cleaning ****"
make clean && make mrproper

# The MAIN Part
echo "**** Setting Toolchain ****"
export ARCH=arm64
echo "**** Kernel defconfig is set to $KERNEL_DEFCONFIG ****"
mkdir -p out

make O=out clean

make O=out mrproper

make O=out cedric_defconfig

make O=out -j$(nproc --all)
# Time for dtb
echo "**** Generating DT.IMG ****"

cd $OUT 
ls
$DTBTOOL/dtbToolCM -2 -o $KERNEL_DIR/arch/arm/boot/dtb -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/qcom/
mv dt.img /scripts/Ak2 
ls /home/runner/android_kernel_motorola_msm8953-common/out
mv arch/arm64/boot/Image.gz zImage
mv arch/arm64/boot/zImage /scripts1/Ak2
 
cd scripts1
# This makes a directory for Builds
echo "Building RADIUM  Kernel for cedric!"
# This prints ""
sudo chmod a+x zip.sh
. zip.sh

# This prints what is is in the builds dir
BUILD_END=$(date +"%s")
# Gets the current time
echo -e "$red RADIUM  Build Started At $BUILD_START and Finished at $BUILD_END"
# This prints "" in red

