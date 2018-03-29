#!/usr/bin/env bash

OUT_FOLDER=${HOME}/kernels/als/hammerhead/out

build-kernel -a arm -gt /opt/arm-eabi-4.8 -d hammerhead_defconfig -f "$(dirname "${OUT_FOLDER}")"
git cl
cp -v "${OUT_FOLDER}/arch/arm/boot/zImage-dtb" .
echo "Kernel version: $(cat "${OUT_FOLDER}/include/config/kernel.release")" > version
zip -r9 initial.zip -x build-zip.sh README.md zImage "modules/*" "patch/*" "ramdisk/*" -- *
java -jar "${HOME}/scripts/bin/zipsigner-2.1.jar" "initial.zip" "hammerhead-als-$(date +%Y%m%d-%H%M).zip"
