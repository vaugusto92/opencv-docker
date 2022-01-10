# opencv-docker

docker build --build-arg platform=java --build-arg version=4.4.0 --tag opencv .

docker run -it --rm opencv bash

java.library.path=/tmp/build/lib

ant -DocvJarDir=/tmp/build/bin -DocvLibDir=/tmp/build/lib rebuild-run
ant -DocvJarDir=/tmp/build/bin/ -DocvLibDir=/tmp/build/lib/ rebuild-run

ant -DocvJarDir=/usr/local/opencv/bin/ -DocvLibDir=/usr/local/opencv/lib/ rebuild-run