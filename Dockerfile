FROM alpine:latest 

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
ENV OPENCV_VERSION=4.6.0
ENV OPENCV_JAVA_BINARY_PATH=/usr/local/opencv/build/bin/
ENV OPENCV_JAVA_LIBRARY_PATH=/usr/local/opencv/build/lib/

COPY ./dependencies.sh ./
RUN . dependencies.sh

COPY ./leiningen.sh ./
RUN bash leiningen.sh

RUN bash -c hash -r

COPY ./opencv-docker-test.sh ./
RUN bash opencv-docker-test.sh


# COPY ./opencv-build.tar.gz ./
# COPY ./install-opencv.sh ./

# RUN bash install-opencv.sh