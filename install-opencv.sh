OPENCV_VERSION=4.6.0
OPENCV_HOME=/usr/local/opencv

mkdir -p $OPENCV_HOME

tar -xvf ~/opencv-build.tar.gz -C $OPENCV_HOME

cd $OPENCV_HOME/build

make install

cd $OPENCV_HOME

cp -r build/bin/ . && cp -r build/lib/ .
rm -rf build
mkdir build && cp -r ./bin build/ && cp -r ./lib build/
rm -rf bin/ && rm -rf lib/
