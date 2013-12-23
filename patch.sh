#!/bin/bash

rm -rf frameworks/av
rm -rf frameworks/native
rm -rf hardware/libhardware_legacy
rm -rf packages/services/Telephony
rm -rf art
rm -rf frameworks/opt/telephony

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

echo "Remove getLteOnGsmMode() (1/2)"
cp patches/packages_services_telephony.patch packages/services/Telephony/packages_services_telephony.patch
cd packages/services/Telephony
git apply packages_services_telephony.patch
rm packages_services_telephony.patch
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

echo ""

echo "Remove getLteOnGsmMode() (2/2)"
cp patches/framework_opt_telephony.patch frameworks/opt/telephony/framework_opt_telephony.patch
cd frameworks/opt/telephony
git apply framework_opt_telephony.patch
rm framework_opt_telephony.patch
cd ../../..

echo ""


