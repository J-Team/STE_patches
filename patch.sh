#!/bin/bash

rm -r bootable/recovery
rm -r hardware/libhardware_legacy
rm -r packages/inputmethods/LatinIME
rm -r packages/services/Telephony

repo sync -l

echo ""

echo "Better compatibility with recoveries"

cp patches/bootable_recovery.patch bootable/recovery/bootable_recovery.patch
cd bootable/recovery
git apply bootable_recovery.patch
rm bootable_recovery.patch
cd ../..

echo ""

echo "Applying vibrator fix"

cp patches/vibrator_fix.patch hardware/libhardware_legacy/vibrator_fix.patch
cd hardware/libhardware_legacy
git apply vibrator_fix.patch
rm vibrator_fix.patch
cd ../..

echo ""

echo "Fix Keyboard crash"

cp patches/LatinIme.patch packages/inputmethods/LatinIME/LatinIME.patch
cd packages/inputmethods/LatinIME
git apply LatinIME.patch
rm LatinIME.patch
cd ../../..

echo ""

echo "Low Incall Volume Fix"
cp patches/Telephony.patch packages/services/Telephony/Telephony.patch
cd packages/services/Telephony
git apply Telephony.patch
rm Telephony.patch
cd ../../..

echo ""
