#!/bin/bash -e

get_sources() {
  mkdir aosp
  cd aosp

  repo init --depth=1 -u https://github.com/AospExtended/manifest.git -b 9.x
  repo sync -c --no-tags --no-clone-bundle -j8 -q
  git clone https://github.com/AmolAmrit/device_xiaomi_kenzo.git -b pie device/xiaomi/kenzo
  git clone https://github.com/AmolAmrit/device_xiaomi_msm8956-common -b pie device/xiaomi/msm8956-common
  git clone https://github.com/AmolAmrit/Escrima_kernel_xiaomi_msm8956 -b pie kernel/xiaomi/msm8956
  git clone https://github.com/AmolAmrit/proprietary_vendor_xiaomi -b pie vendor/xiaomi
  git clone https://github.com/AnggaR96s/hardware_qcom_display -b pie hardware/qcom/display-caf/msm8952
  git clone https://github.com/AnggaR96s/hardware_qcom_audio -b pie hardware/qcom/audio-caf/msm8952
  git clone https://github.com/AnggaR96s/hardware_qcom_media -b lineage-16.0-caf-8952 hardware/qcom/media-caf/msm8952
  git clone https://github.com/LineageOS/android_packages_resources_devicesettings -b lineage-16.0 packages/resources/devicesettings

  cd ..
}

build_firmware() {
  cd aosp

  source build/envsetup.sh
  lunch aosp_kenzo-userdebug
  #mka bacon
  mka aex -j8

  cd ..
}

get_sources
build_firmware
