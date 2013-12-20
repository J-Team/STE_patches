#!/bin/bash

rm -rf frameworks/av
rm -rf frameworks/native
rm -rf hardware/libhardware_legacy

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
