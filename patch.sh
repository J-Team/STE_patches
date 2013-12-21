#!/bin/bash

rm -rf frameworks/av
rm -rf frameworks/native
rm -rf hardware/libhardware_legacy
rm -rf packages/services/Telephony
rm -rf art
rm -rf build

repo sync

echo "Applying Oliver patches - android_frameworks_av"
cp patches/frameworks_av.patch frameworks/av/frameworks_av.patch
cd frameworks/av
git apply frameworks_av.patch
rm frameworks_av.patch
cd ../..

echo ""

echo "Applying Oliver patches - android_frameworks_native"
cp patches/frameworks_native.patch frameworks/native/frameworks_native.patch
cd frameworks/native
git apply frameworks_native.patch
rm frameworks_native.patch
cd ../..

echo ""

echo "Applying vibrator fix"

cp patches/vibrator_fix.patch hardware/libhardware_legacy/vibrator_fix.patch
cd hardware/libhardware_legacy
git apply vibrator_fix.patch
rm vibrator_fix.patch
cd ../..


echo ""

echo "Cherrypicking Oliver patches - android_system_core"
cd system/core
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/34/52034/2
git cherry-pick FETCH_HEAD
cd ../..

echo ""

echo "[PATCH 1/3] Port incall volume workaround to cm11 - q"
echo "[PATCH 2/3] reset the audio volume stream after switching audio mode"
echo "[PATCH 3/3] get BluetoothManager to ask about bt headset (KK implementation)"
cp patches/Telephony.patch packages/services/Telephony/Telephony.patch
cd packages/services/Telephony
git apply Telephony.patch
rm Telephony.patch
cd ../../..

echo ""

echo "ART fix"
echo "[PATCH 1/3] runtime: Add support for dexroot-on-cache"
echo "[PATCH 2/3] runtime: dexroot-on-cache: obey dalvik.vm.dexopt-data-only"
echo "[PATCH 3/3] verifier: Bypass monitor-{enter,exit} depth checks"
cp patches/art/1.patch art/1.patch
cp patches/art/2.patch art/2.patch
cp patches/art/3.patch art/3.patch
cd art
git apply 1.patch
git apply 2.patch
git apply 3.patch
rm 1.patch
rm 2.patch
rm 3.patch
cd ..

echo "Applying Oliver patches - android_frameworks_av"
cp patches/build.patch build/build.patch
cd build
git apply build.patch
rm build.patch
cd ..

