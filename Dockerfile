FROM debian:bullseye-slim

ARG platform
ARG version

COPY ./ ./

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

RUN chmod +x install-opencv.sh && ./install-opencv.sh platform version

WORKDIR /work

CMD bash