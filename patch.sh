#!/bin/bash

rm -r bootable/recovery
rm -r hardware/libhardware_legacy
rm -r packages/services/Telephony
rm -r packages/apps/Bluetooth

repo sync -l

echo ""

echo "Better compatibility with recoveries"

cp patches/bootable_recovery.patch bootable/recovery/bootable_recovery.patch
cd bootable/recovery
git apply bootable_recovery.patch
rm bootable_recovery.patch
git revert 90ca138d051e33ef86be03fc56354eb5705528cb
cd ../..

echo ""

echo "Applying vibrator fix"

cp patches/vibrator_fix.patch hardware/libhardware_legacy/vibrator_fix.patch
cd hardware/libhardware_legacy
git apply vibrator_fix.patch
rm vibrator_fix.patch
cd ../..

echo ""

echo "Low Incall Volume Fix"
cp patches/Telephony.patch packages/services/Telephony/Telephony.patch
cd packages/services/Telephony
git apply Telephony.patch
rm Telephony.patch
cd ../../..

echo ""

echo "Send all files by Bluetooth"
cp patches/BT.patch packages/apps/Bluetooth/BT.patch
cd packages/apps/Bluetooth
git apply BT.patch
rm BT.patch
cd ../../..

echo ""
