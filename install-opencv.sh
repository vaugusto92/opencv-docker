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

cmake_options="-DBUILD_TESTS=OFF -DBUILD_opencv_python2=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$version/modules"

if [ $platform = 'java' ]; then
  cmake_options="-DBUILD_TESTS=OFF -DBUILD_SHARED_LIBS=OFF -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$version/modules"
fi

cd /tmp

wget -q -O /tmp/opencv.tar.gz https://codeload.github.com/opencv/opencv/tar.gz/$version
tar -xf /tmp/opencv.tar.gz 

wget -q -O /tmp/opencv_contrib.tar.gz https://codeload.github.com/opencv/opencv_contrib/tar.gz/$version
tar -xf /tmp/opencv_contrib.tar.gz 

mkdir /tmp/build
cd /tmp/build

cmake "$cmake_options" ../opencv-$version/

make -j4
make install

if [ $platform = 'java' ]; then
  cp /tmp/build/bin/*.jar /work
  cp /tmp/build/lib/libopencv_java* /usr/local/lib
fi

# rm -rf /tmp/build
# rm -rf /tmp/opencv*