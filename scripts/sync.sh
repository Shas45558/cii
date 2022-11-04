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
pip3 install dumpyara
pip3 install aospdtgen
wget https://hugeota.d.miui.com/V13.0.5.0.SJCCNXM/miui_LANCELOT_V13.0.5.0.SJCCNXM_9a2b91926f_12.0.zip
python3 -m dumpyara miui_LANCELOT_V13.0.5.0.SJCCNXM_9a2b91926f_12.0.zip
# Exit
exit 0
