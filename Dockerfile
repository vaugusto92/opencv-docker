FROM debian:bullseye-slim

ARG platform
ARG version

COPY ./ ./

RUN mkdir /work && chmod +x install-dependencies.sh && chmod +x install-opencv.sh

RUN ./install-dependencies.sh $platform

RUN ./install-opencv.sh $platform $version

WORKDIR /work

CMD bash