OPENCV_VERSION=4.6.0
OPENCV_HOME=/usr/local/
OPENCV_BUILD=$OPENCV_HOME/opencv/build

echo "Unpacking the tarball with the compiled files."
tar -xf opencv-build.tar.gz -C $OPENCV_HOME
echo "Done."

cd $OPENCV_BUILD
find ./ -type f -exec sed -i -e 's/\/home\/runner\/opencv\//\/usr\/local\/opencv\//g' {} \;
find ./ -type f -exec sed -i -e 's/\/usr\/local\/bin\/cmake/\/usr\/bin\/cmake/g' {} \;

make install

# cd $OPENCV_HOME/opencv

# cp -r build/bin/ . && cp -r build/lib/ .
# rm -rf build
# mkdir build && cp -r ./bin build/ && cp -r ./lib build/
# rm -rf bin/ && rm -rf lib/
