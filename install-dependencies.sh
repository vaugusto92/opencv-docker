#!/bin/bash

platform=$1

if [ -z "$platform" ]; then 
  echo 'Argument platform not provided'
  exit
fi

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

printf "\e[1;34m#########################################################################\n\e[0m"
printf "\e[1;34mInstalling base dependencies...\n\e[0m"
printf "\e[1;34m#########################################################################\n\e[0m"

export DEBIAN_FRONTEND noninteractive
apt-get update
    
apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    make \
    gcc \
    wget \
    vim \
    libglib2.0-0 \
    libgtk2.0-dev \
    libsm6 \
    libxext6 \
    libfontconfig1 \
    libxrender1 \
    libeigen3-dev \
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

if [ $platform = 'python' ]; then
    printf "\e[1;34m#########################################################################\n\e[0m"
    printf "\e[1;34mInstalling Python dependencies...\n\e[0m"
    printf "\e[1;34m#########################################################################\n\e[0m"

    apt-get install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-numpy \
        pkg-config
fi

if [ $platform = 'java' ]; then
    printf "\e[1;34m#########################################################################\n\e[0m"
    printf "\e[1;34mInstalling Java dependencies...\n\e[0m"
    printf "\e[1;34m#########################################################################\n\e[0m"

    apt-get install -y --no-install-recommends ant default-jdk
fi
    
apt-get clean