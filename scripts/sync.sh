#!/bin/bash 

# Source Vars
source $CONFIG

# Change to the Home Directory
cd ~
curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
chmod a+rx /usr/local/bin/repo

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Clone the Sync Repo

# Initialize local repository
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-20.0 -g default,-mips,-darwin,-notdefault
git -C .repo/manifests fetch --unshallow
git -C .repo/manifests revert 670c209ba91d2f5ec0dab84ed2669cde71d35997
git -C .repo/manifests revert 031f9849ea87ac1d784de96a2b8cd4322082e2f1
git clone https://github.com/Arafattex/local_manifest.git --depth 1 -b Lancelot_los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Exit
exit 0
