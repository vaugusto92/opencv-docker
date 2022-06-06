OPENCV_VERSION=4.5.5
OPENCV_TMP=/tmp/opencv

mkdir -p $OPENCV_TMP && cd $OPENCV_TMP

wget -q -O $OPENCV_TMP/opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
unzip -q $OPENCV_TMP/opencv.zip 

mkdir -p $OPENCV_TMP/build && cd $OPENCV_TMP/build

cmake -DBUILD_TESTS=OFF \
      -DBUILD_opencv_java=ON \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_opencv_python2=OFF \
      -DBUILD_opencv_python3=OFF \
      ../opencv-$OPENCV_VERSION/

make -j$(nproc)