#!/bin/bash

rm -r frameworks/av
rm -r frameworks/native
rm -r hardware/libhardware_legacy
rm -r art
rm -r packages/services/Telephony
rm -r packages/apps/ScreenRecorder
rm -r packages/apps/Settings
rm -r system/core

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
cp patches/frameworks_native2.patch frameworks/native/frameworks_native2.patch
cd frameworks/native
git apply frameworks_native.patch
git apply frameworks_native2.patch
rm frameworks_native.patch
rm frameworks_native2.patch
cd ../..

echo ""

echo "Applying vibrator fix"

cp patches/vibrator_fix.patch hardware/libhardware_legacy/vibrator_fix.patch
cd hardware/libhardware_legacy
git apply vibrator_fix.patch
rm vibrator_fix.patch
cd ../..

echo ""

echo "verifier: Bypass monitor-{enter,exit} depth checks"
cp patches/art.patch art/art.patch
cd art
git apply art.patch
rm art.patch
cd ..

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

echo "Remove Audio Support from ScreenRecorder app"
cp patches/ScreenRecorder.patch packages/apps/ScreenRecorder/ScreenRecorder.patch
cd packages/apps/ScreenRecorder
git apply ScreenRecorder.patch
rm ScreenRecorder.patch
cd ../../..

echo ""

echo "Set from Settings ScreenRecorder app"
cp patches/Settings.patch packages/apps/Settings/Settings.patch
cd packages/apps/Settings
git apply Settings.patch
rm Settings.patch
cd ../../..

echo ""

echo "system/core fix"
cp patches/system_core.patch system/core/system_core.patch
cd system/core
git apply system_core.patch
rm system_core.patch
cd ../..

echo ""
