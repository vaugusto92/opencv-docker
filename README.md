# opencv-docker

docker build --build-arg platform=java --build-arg version=4.4.0 --tag opencv .

docker run -it -v $(pwd):/work --rm opencv bash

java.library.path=/tmp/build/lib

ant -DocvJarDir=/tmp/build/bin -DocvLibDir=/tmp/build/lib rebuild-run
ant -DocvJarDir=/tmp/build/bin/ -DocvLibDir=/tmp/build/lib/ rebuild-run

ant -DocvJarDir=/usr/local/opencv/build/bin/ -DocvLibDir=/usr/local/opencv/build/lib/ rebuild-run

ant -DopencvJarPath=$OPENCV_JAVA_BINARY_PATH -DopencvLibraryPath=$OPENCV_JAVA_LIBRARY_PATH rebuild-run
