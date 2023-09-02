#!/bin/bash

cd ~;
mkdir $ROM_NAME;
cd $ROM_NAME;
git config --global user.name "$USERNAME";
git config --global user.email "$USERMAIL";

# Initialize RED source
repo init --depth=1 --no-repo-verify -u $ROM_REPO -b $ROM_BRANCH -g default,-mips,-darwin,-notdefault;

# Sync RED source
repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync;

# Clone GREEN source
git clone $DEVICE_REPO --depth=1 -b $DEVICE_BRANCH "device/$OEM/$CODENAME";
git clone $DEVICE_COMMON_REPO --depth=1 -b $DEVICE_COMMON_BRANCH "device/$OEM/$COMMON";
git clone $VENDOR_REPO --depth=1 -b $VENDOR_BRANCH "vendor/$OEM/$CODENAME";
git clone $VENDOR_COMMON_REPO --depth=1 -b $VENDOR_COMMON_BRANCH "vendor/$OEM/$COMMON";
git clone $KERNEL_REPO --depth=1 -b $KERNEL_BRANCH "kernel/$OEM/$PLATFORM";

exit 0;
