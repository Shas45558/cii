#!/bin/bash 

# Source Vars
source $CONFIG

# Change to the Home Directory
cd ~
curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
chmod a+rx /usr/local/bin/repo
git clone https://github.com/Arafattex/DumprX.git -b main dump
chmod a+rx ~/dump/dumper.sh
chmod a+rx ~/dump/setup.sh
cd dump
./setup.sh
./dumper.sh https://hugeota.d.miui.com/V13.0.5.0.SJCCNXM/miui_LANCELOT_V13.0.5.0.SJCCNXM_9a2b91926f_12.0.zip

# Exit
exit 0
