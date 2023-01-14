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

# Clone clang
git clone --depth=1  $CLANG_SYNC -b $CLANG_BRANCH /toolchains/proton-clang


# Clone Kernel
git clone --depth=1  $KT_LINK -b a13r /kernel


# Exit
exit 0
