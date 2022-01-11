FROM debian:bullseye-slim

ARG platform
ARG version

ENV OPENCV_JAVA_LIBRARY_PATH="/usr/local/opencv/build/lib/"
ENV OPENCV_JAVA_BINARY_PATH="/usr/local/opencv/build/bin/"

COPY ./ ./

RUN mkdir /work && chmod +x install-dependencies.sh && chmod +x install-opencv.sh

RUN ./install-dependencies.sh $platform
RUN ./install-opencv.sh $platform $version

WORKDIR /work

CMD bash