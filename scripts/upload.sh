#!/bin/bash

# Source Vars
source $CONFIG

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Change to the Source Directory
cd ~

# Color
ORANGE='\033[0;33m'

# Display a message
echo "============================"
echo "Uploading the Build..."
echo "============================"

# Change to the Output Directory
cd kernel/AnyKernel3-master

# Set FILENAME var
FILENAME=Shas-Dream-*.zip

# Upload to oshi.at
if [ -z "$TIMEOUT" ];then
    TIMEOUT=20160
fi

# Upload to WeTransfer
# NOTE: the current Docker Image, "registry.gitlab.com/sushrut1101/docker:latest", includes the 'transfer' binary by Default
transfer wet $FILENAME > link.txt || { echo "ERROR: Failed to Upload the Build!" && exit 1; }
transfer wet $FILENAME2 > link2.txt || { echo "ERROR: Failed to Upload the Build!" && exit 1; }


DL_LINK=$(cat link.txt | grep Download | cut -d\  -f3)
DL_LINK2=$(cat link2.txt | grep Download | cut -d\  -f3)

# Show the Download Link
echo "=============================================="
echo "Download Link: ${DL_LINK}" || { echo "ERROR: Failed to Upload the Build!"; }
echo "Download Link: ${DL_LINK2}" || { echo "ERROR: Failed to Upload the Build!"; }
echo "=============================================="

DATE_L=$(date +%d\ %B\ %Y)
DATE_S=$(date +"%T")

# Send the Message on Telegram
echo -e \
"
ðŸ¦Š OrangeFox Recovery CI
âœ„1¤7 Build Completed Successfully!
ðŸ“± Device: "${DEVICE}"
ðŸ–¥ Build System: "${TWRP_BRANCH}"
â¬‡ï¸ Download Link: <a href=\"${DL_LINK}\">Here</a>
â¬‡ï¸ Download Link: <a href=\"${DL_LINK2}\">Here</a>
ðŸ“… Date: "$(date +%d\ %B\ %Y)"
â„1¤7 Time: "$(date +%T)"
" > tg.html

TG_TEXT=$(< tg.html)

telegram_message "$TG_TEXT"

echo " "

# Exit
exit 0
