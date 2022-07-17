OPENCV_VERSION=4.6.0
OPENCV_HOME=/usr/local/opencv

mkdir -p $OPENCV_HOME

echo "Unpacking the tarball with the compiled files."
tar -xf opencv-build.tar.gz -C $OPENCV_HOME
echo "Done."

cd opencv

for i in *; do
  sed -i 's/\/home\/runner\/opencv\//\/usr\/local\/opencv\//g' $i
done

# cd $OPENCV_HOME/build

# make install

# cd $OPENCV_HOME

# cp -r build/bin/ . && cp -r build/lib/ .
# rm -rf build
# mkdir build && cp -r ./bin build/ && cp -r ./lib build/
# rm -rf bin/ && rm -rf lib/
