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
  mkdir /usr/local/opencv

  mkdir /usr/local/opencv/bin
  mkdir /usr/local/opencv/lib
  mkdir /usr/local/opencv/samples
  
  mkdir /usr/local/opencv/samples/java
  mkdir /usr/local/opencv/samples/clojure


  cp -r /tmp/build/bin/. /usr/local/opencv/bin
  cp -r /tmp/build/lib/. /usr/local/opencv/lib

  cp -r /tmp/opencv-4.4.0/samples/java/ant/. /usr/local/opencv/samples/java
  cp -r /tmp/opencv-4.4.0/samples/java/clojure/. /usr/local/opencv/samples/clojure

  # lein localrepo install opencv-$version.jar opencv/opencv $version
  # lein localrepo install opencv-$version.jar opencv/opencv $version
fi

rm -rf /tmp/build
rm -rf /tmp/opencv*