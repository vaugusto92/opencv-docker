VERSION=$1
FOLDER=/usr/local/opencv

setupClojureEnvironment() {
  jar_version="${VERSION//./""}"

  build_folder=$folder/build
  native_folder=$build_folder/native/linux/x86_64/

  mkdir -p $build_folder/clj-opencv && cd $build_folder/clj-opencv
  cp $build_folder/bin/opencv-$jar_version.jar .

  mkdir -p $build_folder/native/linux/x86_64
  cp $build_folder/lib/libopencv_java$jar_version.so $native_folder
  jar -cMf opencv-native-$jar_version.jar $build_folder/native

  mkdir ~/.lein
  cd ~/.lein
  echo "{:user {:plugins [[lein-localrepo \"0.5.2\"]]}}" > profiles.clj

  cd $build_folder/clj-opencv
  lein localrepo install opencv-$jar_version.jar opencv/opencv $VERSION
  lein localrepo install opencv-native-$jar_version.jar opencv/opencv-native $VERSION
}

mkdir $FOLDER && cd $FOLDER

wget -q -O $FOLDER/opencv.tar.gz https://codeload.github.com/opencv/opencv/tar.gz/$VERSION
tar -xf $FOLDER/opencv.tar.gz 

wget -q -O $FOLDER/opencv_contrib.tar.gz https://codeload.github.com/opencv/opencv_contrib/tar.gz/$VERSION
tar -xf $FOLDER/opencv_contrib.tar.gz 

mkdir $FOLDER/build && cd $FOLDER/build

cmake "$cmake_options" ../opencv-$VERSION/

make -j4
make install

cd $FOLDER

cp -r build/bin/ . && cp -r build/lib/ .
rm -rf build
mkdir build && cp -r ./bin build/ && cp -r ./lib build/
rm -rf bin/ && rm -rf lib/

rm -rf opencv-$VERSION
rm -rf opencv_contrib-$VERSION
rm -f opencv.tar.gz
rm -f opencv_contrib.tar.gz

setupClojureEnvironment