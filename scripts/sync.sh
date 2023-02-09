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
git clone --depth=1 https://github.com/Arafattex/oc_a13r -b a13r kernel/xiaomi/mt6768
git clone https://github.com/vijaymalav564/vortex-clang.git -b master --depth=1 prebuilts/clang/host/linux-x86/clang-proton   
# Exit
exit 0
