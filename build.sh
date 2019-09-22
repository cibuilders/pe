#!/bin/bash -e

get_sources() {
  mkdir aosp
  cd aosp

  repo init --depth=1 -u https://github.com/PixelExperience/manifest -b pie-plus
  repo sync -c --no-tags --no-clone-bundle -j8 -q
  git clone https://github.com/PixelExperience-Devices/device_xiaomi_kenzo.git -b pie device/xiaomi/kenzo
  git clone https://github.com/baalajimaestro/msm8956-common.git -b pie device/xiaomi/msm8956-common
  git clone https://github.com/baalajimaestro/android_kernel_xiaomi_msm8956 -b pie kernel/xiaomi/msm8956 --depth=1
  git clone https://github.com/baalajimaestro/vendor_xiaomi_kenzo.git -b pie vendor/xiaomi --depth=1

  cd ..
}

build_firmware() {
  cd aosp

  source build/envsetup.sh
  echo 'export USE_CCACHE=1' >> ~/.bashrc
  source ~/.bashrc
  ccache -M 50
  export ALLOW_MISSING_DEPENDENCIES=true
  export KBUILD_BUILD_USER="AnggaR96s"
  export KBUILD_BUILD_HOST="CI-BuildBot"
  lunch aosp_kenzo-userdebug
  #mka bacon
  mka bacon -j8
  cd ..
}

upload() {
  cd aosp/out/target/product/xiaomi/kenzo
  curl --upload-file ./PixelExperience_Plus*kenzo*.zip https://transfer.sh
}

get_sources
build_firmware
upload
