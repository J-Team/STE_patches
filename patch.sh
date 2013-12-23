#!/bin/bash

rm -r frameworks/av
rm -r frameworks/native
rm -r hardware/libhardware_legacy
rm -r packages/services/Telephony
rm -r art
rm -r frameworks/opt/telephony
rm -r frameworks/base

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

# echo "Remove getLteOnGsmMode() (1/3) - packages_services_Telephony"
# cp patches/packages_services_telephony.patch packages/services/Telephony/packages_services_telephony.patch
# cd packages/services/Telephony
# git apply packages_services_telephony.patch
# rm packages_services_telephony.patch
# cd ../../..

# echo ""

# echo "Remove getLteOnGsmMode() (2/3) - frameworks_opt_telephony"
# cp patches/framework_opt_telephony.patch frameworks/opt/telephony/framework_opt_telephony.patch
# cd frameworks/opt/telephony
# git apply framework_opt_telephony.patch
# rm framework_opt_telephony.patch
# cd ../../..

# echo ""

# echo "Remove getLteOnGsmMode() (3/3) - frameworks_base"
# cp patches/frameworks_base.patch frameworks/base/frameworks_base.patch
# cd frameworks/base
# git apply frameworks_base.patch
# rm frameworks_base.patch
# cd ../..

# echo ""
