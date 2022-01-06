FROM debian:bullseye-slim

WORKDIR /work

COPY ./ ./

RUN ./install-opencv.sh system-update
RUN ./install-opencv.sh build-tools
RUN ./install-opencv.sh gui
RUN ./install-opencv.sh media-io
# RUN ./install-opencv.sh video-io
# RUN ./install-opencv.sh linalg
# RUN ./install-opencv.sh python
# RUN ./install-opencv.sh java
# RUN ./install-opencv.sh docs
# RUN ./install-opencv.sh opencv

CMD [ "bash" ]