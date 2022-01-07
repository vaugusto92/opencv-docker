#!/bin/bash

packages=()
specialCommands=('system-update' 'opencv')

readPackages() {
  unset arr
  mapfile -t packages < $1.txt
}

installPackages() {
  apt-get update &&
  apt-get install -y --no-install-recommends "${packages[@]}" &&
  apt-get clean
}

checkInstalledPackages() {
  echo
  for package in "${packages[@]}"
  do
    output="Checking for the package $package ... "
    check=$(dpkg --get-selections | grep $package)
    [ -z "$check" ] && echo $output" not installed." || echo $output" installed."
  done
  echo
}

if [ $1 = 'opencv' ]; then
  wget -q -O /tmp/opencv.tar.gz https://codeload.github.com/opencv/opencv/tar.gz/$2
  cd /tmp/
  tar -xf /tmp/opencv.tar.gz
  wget -q -O /tmp/opencv_contrib.tar.gz https://codeload.github.com/opencv/opencv_contrib/tar.gz/$2
  cd /tmp/
  tar -xf /tmp/opencv_contrib.tar.gz
  mkdir /tmp/build
  cd /tmp/build
  cmake -DBUILD_TESTS=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$2/modules ../opencv-$2/
  make -j4
   make install
  rm -rf /tmp/build
  rm -rf /tmp/opencv*
fi

if [[ ! " ${specialCommands[*]} " =~  $1 ]]; then
  export DEBIAN_FRONTEND noninteractive
  readPackages $1
  installPackages
  checkInstalledPackages
fi