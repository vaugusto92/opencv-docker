#!/bin/bash

platform=$1
version=$2

if [[ -z "$platform" ]]; then 
  echo 'Argument platform not provided'
  exit
fi

if [[ -z "$version" ]]; then 
  echo 'Argument version not provided'
  exit
fi

wget -q -O /tmp/opencv.tar.gz https://codeload.github.com/opencv/opencv/tar.gz/$version

cd /tmp/ 
tar -xf /tmp/opencv.tar.gz 

wget -q -O /tmp/opencv_contrib.tar.gz https://codeload.github.com/opencv/opencv_contrib/tar.gz/$version
cd /tmp/ 
tar -xf /tmp/opencv_contrib.tar.gz 

mkdir /tmp/build
cd /tmp/build 

cmake -DBUILD_TESTS=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$version/modules ../opencv-$version/


make -j4
make install

rm -rf /tmp/build
rm -rf /tmp/opencv*


    

# -DBUILD_SHARED_LIBS=OFF ..