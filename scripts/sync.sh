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

# Clone Kernel
git clone --depth=1  $KT_LINK -b a13r kernel

# Clone clang

mkdir clang-llvm
mkdir gcc64-aosp
mkdir gcc32-aosp
wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/android11-qpr3-release/clang-r383902b1.tar.gz
tar -C ~/clang-llvm/ -zxvf clang-r383902b1.tar.gz
wget https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/+archive/refs/tags/android-11.0.0_r35.tar.gz
tar -C ~/gcc64-aosp/ -zxvf android-11.0.0_r35.tar.gz
wget http://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/+archive/refs/tags/android-11.0.0_r34.tar.gz
tar -C ~/gcc32-aosp/ -zxvf android-11.0.0_r34.tar.gz
#git clone https://github.com/rama982/AnyKernel3 --depth=1 "$OUTDIR"/AnyKernel

# Exit
exit 0
