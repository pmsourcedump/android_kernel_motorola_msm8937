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
git clone https://github.com/infixremix/scripts

# These clone the Kernel and assets
mkdir Builds
cd scripts
# This makes a directory for Builds
echo "Building RADIUM  Kernel for cedric!"
# This prints ""
sudo chmod a+x build.sh
. build.sh
ls
# This prints what is is in the builds dir
BUILD_END=$(date +"%s")
# Gets the current time
echo -e "$red RADIUM  Build Started At $BUILD_START and Finished at $BUILD_END"
# This prints "" in red
