#!/bin/bash

# Example of commands to make patches:

# Make only the patch:
#      from                                        to
# git diff 886c0c85904a981b704e6a9ddf9a8dab02ca3f1a 42411ef --> name.patch
#
#
# This writes also additional informations in the patch
#              from ---------------------------------------> now
# git format-patch 886c0c85904a981b704e6a9ddf9a8dab02ca3f1a --stdout > name.patch



rm -rf packages/apps/Settings
rm -rf packages/services/Telephony
rm -rf art

repo sync

echo ""

echo "[PATCH 1/1] Add native java screen recorder [2/2]"
cp patches/recorder.patch packages/apps/Settings/recorder.patch
cd packages/apps/Settings
git apply recorder.patch
rm recorder.patch
cd ../../..

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

echo ""

