FROM debian:bullseye-slim

RUN export DEBIAN_FRONTEND noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        make \
        gcc \
        wget \
        default-jdk \
        libglib2.0-0 \
        libgtk2.0-dev \
        libsm6 \
        libxext6 \
        libfontconfig1 \
        libxrender1 \
        libeigen3-dev \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-numpy \
        pkg-config \
        libavformat-dev \
        libswscale-dev \
        libavcodec-dev \
        libavformat-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libtesseract-dev \
        tesseract-ocr-eng \
        libzbar-dev \
        && \
    apt-get clean

RUN wget -q -O /tmp/opencv.tar.gz https://codeload.github.com/opencv/opencv/tar.gz/4.5.5 && \
    cd /tmp/ && tar -xf /tmp/opencv.tar.gz && \
    wget -q -O /tmp/opencv_contrib.tar.gz https://codeload.github.com/opencv/opencv_contrib/tar.gz/4.5.5 && \
    cd /tmp/ && tar -xf /tmp/opencv_contrib.tar.gz && \
    mkdir /tmp/build && cd /tmp/build && \
    cmake -DBUILD_TESTS=OFF -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-4.5.5/modules ../opencv-4.5.5/ && \
    make -j4 && make install && \
    rm -rf /tmp/build && rm -rf /tmp/opencv*

WORKDIR /work

CMD bash