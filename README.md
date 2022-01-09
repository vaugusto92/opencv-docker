# opencv-docker

docker build --build-arg platform=java --build-arg version=4.4.0 --tag opencv .

docker run -it --rm -v $(pwd):/work opencv bash

java.library.path=/tmp/buil/lib
ant -DocvJarDir=/tmp/build/bin rebuild-run