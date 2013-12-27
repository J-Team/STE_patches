#!/bin/bash

rm -rf frameworks/av
rm -rf frameworks/native
rm -rf hardware/libhardware_legacy
rm -rf packages/apps/Phone
rm -rf system/core

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

echo "Applying low incall volume fix"
cp patches/packages_apps_Phone.patch packages/apps/Phone/packages_apps_Phone.patch
cd packages/apps/Phone
git apply packages_apps_Phone.patch
rm packages_apps_Phone.patch
cd ../..


echo ""

echo "Cherrypicking Oliver patches - android_system_core"
cd system/core
cp patches/system_core.patch system/core/system_core.patch
cd system/core
git apply system_core.patch
rm system_core.patch
cd ../..

echo ""
