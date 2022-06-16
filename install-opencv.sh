OPENCV_VERSION=4.5.5
FOLDER=/usr/local/opencv

mkdir -p $FOLDER

tar -xvf ~/opencv-build.tar.gz -C $FOLDER

cd $FOLDER && ls -lrt