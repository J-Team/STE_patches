#!/bin/bash

#rm -r frameworks/av
#rm -r frameworks/native
rm -r bootable/recovery
rm -r hardware/libhardware_legacy
rm -r packages/inputmethods/LatinIME
rm -r packages/services/Telephony
#rm -r system/core
#rm -r system/vold

repo sync -l

#echo "android_frameworks_av"
#cp patches/frameworks_av.patch frameworks/av/frameworks_av.patch
#cd frameworks/av
#git apply frameworks_av.patch
#rm frameworks_av.patch
#git revert ff7ae18ca39ced274f37856b8da9dc1e446f69dd

#cd ../..

#echo ""

#echo "android_frameworks_native"
#cp patches/frameworks_native.patch frameworks/native/frameworks_native.patch
#cd frameworks/native
#git apply frameworks_native.patch
#rm frameworks_native.patch
#git revert 8124b181d4b5a3a44796fdb0e3ea4e4171f102c7
#cd ../..

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

#echo "system/core fix"
#cp patches/system_core.patch system/core/system_core.patch
#cd system/core
#git apply system_core.patch
#rm system_core.patch
#cd ../..

#echo ""

#echo "system/vold fix"
#cp patches/system_vold.patch system/vold/system_vold.patch
#cd system/vold
#git apply system_vold.patch
#rm system_vold.patch
#cd ../..

#echo ""
