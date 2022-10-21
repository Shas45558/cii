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
repo init -u https://github.com/PixelExperience/manifest -b thirteen
curl -o .repo/local_manifests/local_manifests.xml https://raw.githubusercontent.com/Arafattex/local_manifest/Lancelot_pixell/local_manifest.xml --create-dirs
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Exit
exit 0
