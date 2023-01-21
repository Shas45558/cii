#!/bin/bash

# Device
export TWRP_BRANCH="v3_11.0"
export DT_LINK="https://github.com/Arafattex/twrp_tree_mt6768 -b Lancelot_a13r"

export DEVICE="lancelot"
export OEM="xiaomi"

# Build Target
## "recoveryimage" - for A-Only Devices without using Vendor Boot
## "bootimage" - for A/B devices without recovery partition (and without vendor boot)
## "vendorbootimage" - for devices Using vendor boot for the recovery ramdisk (Usually for devices shipped with Android 12 or higher)
export TARGET="recoveryimage"

export OUTPUT="Twrp*.zip"
# Not Recommended to Change
export SYNC_PATH="$HOME/work" # Full (absolute) path.
export USE_CCACHE=1
export CCACHE_SIZE="25G"
export CCACHE_DIR="$HOME/work/.ccache"
export J_VAL=16
