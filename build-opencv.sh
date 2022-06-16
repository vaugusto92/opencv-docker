OPENCV_TMP=~/opencv

createBuildDirectories() {
  mkdir -p $OPENCV_TMP && mkdir -p $OPENCV_TMP/build
}

downloadOpenCV() {
  OPENCV_VERSION=$1
  wget -q -O $OPENCV_TMP/opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
  unzip -q $OPENCV_TMP/opencv.zip 
}

buildOpenCV() {
  OPENCV_VERSION=4.5.5

  createBuildDirectories
  cd $OPENCV_TMP

  downloadOpenCV $OPENCV_VERSION 
  cd $OPENCV_TMP/build

  cmake -DBUILD_TESTS=OFF \
        -DBUILD_opencv_java=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DBUILD_opencv_python2=OFF \
        -DBUILD_opencv_python3=OFF \
        ../opencv-$OPENCV_VERSION/

  make -j$(nproc)

  echo "Constructing a tarball with the compiled files."
  cd ~/opencv && tar -cvzf opencv-build.tar.gz *
  echo "Done."
}

function ensureBuildSuccess() {
  find . -type f -name "opencv-build.tar.gz" | grep . || exit 1
}

buildOpenCV
ensureBuildSuccess