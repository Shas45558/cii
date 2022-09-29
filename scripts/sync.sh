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


# Clone Trees
DT_PATH="device/${OEM}/${DEVICE}"
git clone $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }


# Exit
exit 0
