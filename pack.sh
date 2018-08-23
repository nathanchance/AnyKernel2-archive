#!/usr/bin/env bash

source ${HOME}/scripts/common

KN=fk-$(date +%Y%m%d-%H%M)
OUT_FOLDER=${PWD}/../franco-op5/out
SIGNED_ZIP=${KN}.zip
UNSIGNED_ZIP=${KN}-unsigned.zip

# Clean folder
git cl

# Copy image
cp -v "${OUT_FOLDER}"/arch/arm64/boot/Image.gz-dtb .

# Sign and copy module
mkdir -p ramdisk/modules
cp -v "${OUT_FOLDER}"/drivers/staging/qcacld-3.0/wlan.ko ramdisk/modules
${TC_FOLDER}/aosp-gcc-arm64/bin/aarch64-linux-android-strip --strip-unneeded ramdisk/modules/wlan.ko
if [[ -f ${OUT_FOLDER}/scripts/sign-file ]]; then
    "${OUT_FOLDER}"/scripts/sign-file sha512 \
                                      "${OUT_FOLDER}/certs/signing_key.pem" \
                                      "${OUT_FOLDER}/certs/signing_key.x509" \
                                      ramdisk/modules/wlan.ko
fi

# Package and sign zip
zip -r9 "${UNSIGNED_ZIP}" -x pack.sh -- *
java -jar "${BIN_FOLDER}/zipsigner-3.0.jar" \
          "${UNSIGNED_ZIP}" \
          "${SIGNED_ZIP}"

# Upload zip
CHAT_ID=-1001107088684 tg_upload "${SIGNED_ZIP}" "Test kernel for OxygenOS 5.1.5 and Open Beta 14/16"
