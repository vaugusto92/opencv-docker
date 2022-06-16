FROM alpine:latest AS environment

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
ENV OPENCV_VERSION=4.5.5
ENV OPENCV_JAVA_BINARY_PATH=/usr/local/opencv/build/bin/
ENV OPENCV_JAVA_LIBRARY_PATH=/usr/local/opencv/build/lib/

# Install all required packages
COPY ./dependencies.sh ./
RUN . dependencies.sh

COPY ./leiningen.sh ./
RUN . leiningen.sh