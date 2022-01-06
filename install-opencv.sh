#!/bin/bash

OPENCV_VERSION='4.5.5'

packages=()
specialCommands=('system-update' 'opencv')

readPackages() {
  unset arr
  mapfile -t packages < $1.txt
}

installPackages() {
  apt install -y "${packages[@]}"
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

if [ $1 = 'system-update' ]; then
  apt -y update
  apt -y upgrade 
  apt -y dist-upgrade
  apt -y autoremove
fi

if [ $1 = 'opencv' ]; then
  apt install -y unzip wget
  wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
  unzip ${OPENCV_VERSION}.zip
  rm ${OPENCV_VERSION}.zip
  mv opencv-${OPENCV_VERSION} OpenCV
  cd OpenCV
  mkdir build
  cd build
  cmake -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..
  make -j4
  make install
  ldconfig
fi

if [[ ! " ${specialCommands[*]} " =~  $1 ]]; then
  readPackages $1
  installPackages
  checkInstalledPackages
fi