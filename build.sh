#!/bin/bash -e

get_sources() {
  mkdir aosp
  cd aosp

  repo init --depth=1 -u https://github.com/AospExtended/android.git -b 9.x
  repo sync -c --no-tags --no-clone-bundle -j8 -q

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
