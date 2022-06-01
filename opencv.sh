OPENCV_VERSION=$1
FOLDER=/usr/local/opencv

setupClojureEnvironment() {
  jar_version="${OPENCV_VERSION//./""}"

  build_folder=$FOLDER/build
  native_folder=$build_folder/native/linux/x86_64/

  mkdir -p $build_folder/clj-opencv && cd $build_folder/clj-opencv
  cp $build_folder/bin/opencv-$jar_version.jar .

  mkdir -p $build_folder/native/linux/x86_64
  cp $build_folder/lib/libopencv_java$jar_version.so $native_folder
  jar -cMf opencv-native-$jar_version.jar $build_folder/native

  mkdir -p ~/.lein
  cd ~/.lein
  echo "{:user {:plugins [[lein-localrepo \"0.5.2\"]]}}" > profiles.clj

  cd $build_folder/clj-opencv
  lein localrepo install opencv-$jar_version.jar opencv/opencv $OPENCV_VERSION
  lein localrepo install opencv-native-$jar_version.jar opencv/opencv-native $OPENCV_VERSION
}

mkdir $FOLDER && cd $FOLDER

wget -q -O $FOLDER/opencv.tar.gz https://codeload.github.com/opencv/opencv/tar.gz/$OPENCV_VERSION
tar -xf $FOLDER/opencv.tar.gz 

wget -q -O $FOLDER/opencv_contrib.tar.gz https://codeload.github.com/opencv/opencv_contrib/tar.gz/$OPENCV_VERSION
tar -xf $FOLDER/opencv_contrib.tar.gz 

mkdir $FOLDER/build && cd $FOLDER/build

cmake -DBUILD_TESTS=OFF \
      -DBUILD_opencv_java=ON \
      -DBUILD_SHARED_LIBS=OFF \
      -DBUILD_opencv_python2=OFF \
      -DBUILD_opencv_python3=OFF \
      -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$OPENCV_VERSION/modules \
      ../opencv-$OPENCV_VERSION/

make -j$(nproc)
make install

cd $FOLDER

cp -r build/bin/ . && cp -r build/lib/ .
rm -rf build
mkdir build && cp -r ./bin build/ && cp -r ./lib build/
rm -rf bin/ && rm -rf lib/

rm -rf opencv-$OPENCV_VERSION
rm -rf opencv_contrib-$OPENCV_VERSION
rm -f opencv.tar.gz
rm -f opencv_contrib.tar.gz

setupClojureEnvironment