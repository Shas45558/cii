#!/bin/bash

# Device
export TWRP_BRANCH="android-11.0"
export DT_LINK="https://github.com/gitclone-url/android_device_micromax_E7544 -b PBRP-11"

export DEVICE="E7544"
export OEM="micromax"

# Build Target
## "recoveryimage" - for A-Only Devices without using Vendor Boot
## "bootimage" - for A/B devices without recovery partition (and without vendor boot)
## "vendorbootimage" - for devices Using vendor boot for the recovery ramdisk (Usually for devices shipped with Android 12 or higher)
export TARGET="bootimage"

export OUTPUT="Twrp*.zip"
# Not Recommended to Change
export SYNC_PATH="$HOME/work" # Full (absolute) path.
export USE_CCACHE=1
export CCACHE_SIZE="50G"
export CCACHE_DIR="$HOME/work/.ccache"
export J_VAL=16
