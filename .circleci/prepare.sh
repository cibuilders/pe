#!/bin/bash -e

# non-interactive
export DEBIAN_FRONTEND=noninteractive
echo 'APT::Get::Assume-Yes "true";' | sudo tee -a /etc/apt/apt.conf.d/90non-interactive
echo 'DPkg::Options "--force-confnew";' | sudo tee -a /etc/apt/apt.conf.d/90non-interactive

# dependencies
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
sudo apt-get install -y openjdk-8-jre

sudo apt-get install --no-install-recommends -y \
binutils-static curl figlet git-core libesd0-dev libwxgtk2.8-dev schedtool \
git-core gnupg flex bison gperf build-essential zip curl \
zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils \
xsltproc unzip
sudo apt-get install --no-install-recommends -y \
  apt-utils dialog locales sudo ca-certificates ccache parallel \
  net-tools netcat nano bzip2 gzip tar xz-utils curl wget \
  bc bison build-essential flex g++-multilib gcc-multilib \
  git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev \
  lib32z-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev \
  libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool \
  squashfs-tools xsltproc openjdk-8-jdk python zip unzip zlib1g-dev \
  libc6-dev-i386 x11proto-core-dev libx11-dev libgl1-mesa-dev make bc

sudo apt-get update -y
sudo apt-get install -y adb autoconf automake axel bc bison build-essential clang cmake expat fastboot flex \
g++ g++-multilib gawk gcc gcc-multilib gnupg gperf htop imagemagick lib32ncurses5-dev lib32z1-dev libtinfo5 \
libc6-dev libcap-dev libexpat1-dev libgmp-dev liblz4-* liblzma* libmpc-dev libmpfr-dev \
libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml2 libxml2-utils lzma* lzop maven ncftp ncurses-dev \
patch patchelf pkg-config pngcrush pngquant python python-all-dev re2c schedtool squashfs-tools subversion texinfo \
unzip w3m xsltproc zip zlib1g-dev
sudo apt-get clean

# repo
sudo curl -sSL https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo
sudo chmod a+x /usr/local/bin/repo

# timezone
sudo ln -sf /usr/share/zoneinfo/EET /etc/localtime

# swap
sudo dd if=/dev/zero of=/swap count=6144 bs=1M
sudo chmod 600 /swap
sudo mkswap /swap
sudo swapon /swap
sudo sysctl -w vm.swappiness=80

# git
git config --global user.name "AnggaR96s"
git config --global user.email "kiritoclasher@gmail.com"
git config --global color.ui auto
git config --global log.date iso

# ccache
ccache -M 50G
