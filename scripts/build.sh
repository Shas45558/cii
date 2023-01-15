#!/bin/bash

# Source Configs
source $CONFIG

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Change to the Source Directry
cd ~



# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 10G
else
    ccache -M ${CCACHE_SIZE}
fi



# Send the Telegram Message

echo -e \
"
🦊 OrangeFox Recovery CI

✔️ The Build has been Triggered!

📱 Device: "${DEVICE}"
🖥 Build System: "Kernel"
🌲 Logs: <a href=\"https://cirrus-ci.com/build/${CIRRUS_BUILD_ID}\">Here</a>
" > tg.html

TG_TEXT=$(< tg.html)

telegram_message "${TG_TEXT}"
echo " "
export PATH="$HOME/clang-llvm/bin:$PATH"
export PATH="$HOME/gcc64-aosp/bin:$PATH"
export PATH="$HOME/gcc32-aosp/bin:$PATH"
cd kernel 
mkdir out
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
make O=out ARCH=arm64 lancelot_defconfig
make -j"$PROCS" O=out \
                  ARCH=arm64 \
                  CC=clang \
                  CLANG_TRIPLE=aarch64-linux-gnu- \
                  CROSS_COMPILE=aarch64-linux-android- \
                  CROSS_COMPILE_ARM32=arm-linux-androideabi- \
                  LD=ld.lld \
                  NM=llvm-nm \
                  OBJCOPY=llvm-objcopy
# Exit
exit 0
