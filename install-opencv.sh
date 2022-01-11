#!/bin/bash

platform=$1
version=$2
folder=/usr/local/opencv

if [[ -z "$platform" ]]; then 
  echo 'Argument platform not provided'
  exit
fi

if [[ -z "$version" ]]; then 
  echo 'Argument version not provided'
  exit
fi

setupClojureEnvironment() {
  jar_version="${version//./""}"

  build_folder=$folder/build
  native_folder=$build_folder/native/linux/x86_64/

  mkdir -p $build_folder/clj-opencv && cd $build_folder/clj-opencv
  cp $build_folder/bin/opencv-$jar_version.jar .

  mkdir -p $build_folder/native/linux/x86_64
  cp $build_folder/lib/libopencv_java$jar_version.so $native_folder
  jar -cMf opencv-native-$jar_version.jar $build_folder/native

  echo "{:user {:plugins [[lein-localrepo \"0.5.2\"]]}}" > ~/.lein/profiles.clj

  cd $build_folder/clj-opencv
  lein localrepo install opencv-$jar_version.jar opencv/opencv $version
  lein localrepo install opencv-native-$jar_version.jar opencv/opencv-native $version
}

cmake_options="-DBUILD_TESTS=OFF -DBUILD_opencv_python2=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$version/modules"

if [ $platform = 'java' ]; then
  cmake_options="-DBUILD_TESTS=OFF -DBUILD_SHARED_LIBS=OFF -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$version/modules"
fi

mkdir $folder && cd $folder

wget -q -O $folder/opencv.tar.gz https://codeload.github.com/opencv/opencv/tar.gz/$version
tar -xf $folder/opencv.tar.gz 

wget -q -O $folder/opencv_contrib.tar.gz https://codeload.github.com/opencv/opencv_contrib/tar.gz/$version
tar -xf $folder/opencv_contrib.tar.gz 

mkdir $folder/build && cd $folder/build

cmake "$cmake_options" ../opencv-$version/

make -j4
make install

if [ $platform = 'java' ]; then
  cd $folder

  cp -r build/bin/ . && cp -r build/lib/ .
  rm -rf build
  mkdir build && cp -r ./bin build/ && cp -r ./lib build/
  rm -rf bin/ && rm -rf lib/

  mkdir -p $folder/samples/java && mkdir -p $folder/samples/clojure

  cp -r $folder/opencv-$version/samples/java/ant/. samples/java
  cp -r $folder/opencv-$version/samples/java/clojure/. samples/clojure

  rm -rf opencv-$version
  rm -rf opencv_contrib-$version
  rm -f opencv.tar.gz
  rm -f opencv_contrib.tar.gz

  setupClojureEnvironment
fi