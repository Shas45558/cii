#!/bin/bash

# Source Vars
source $CONFIG

# Change to the Home Directory
cd ~

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Clone the Sync Repo
repo init --depth=1 -u $TWRP_SYNC -b $TWRP_BRANCH
repo sync

# Clone Trees
DT_PATH="device/${OEM}/${DEVICE}"
git clone $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 https://github.com/Arafattex/oc_a13r -b twrp kernel/xiaomi/mt6768
got clone --depth=1 https://gitlab.com/ImSurajxD/clang-r450784d.git -b master prebuilts/clang/host/linux-x86/clang-r450784d
git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-11.0.0_r29 prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
# Exit
exit 0
