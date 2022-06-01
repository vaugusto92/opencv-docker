FROM alpine:latest

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
ENV OPENCV_VERSION=4.4.0
ENV OPENCV_JAVA_BINARY_PATH=/usr/local/opencv/build/bin/
ENV OPENCV_JAVA_LIBRARY_PATH=/usr/local/opencv/build/lib/

# Add Edge repos
RUN echo -e "\n\
@edgemain http://nl.alpinelinux.org/alpine/edge/main\n\
@edgecomm http://nl.alpinelinux.org/alpine/edge/community\n\
@edgetest http://nl.alpinelinux.org/alpine/edge/testing"\
  >> /etc/apk/repositories

# Install required packages
COPY ./dependencies.sh ./
RUN chmod +x dependencies.sh && ./dependencies.sh

COPY ./leiningen.sh ./
RUN chmod +x leiningen.sh && ./leiningen.sh

COPY ./opencv.sh ./
RUN chmod +x opencv.sh && ./opencv.sh $OPENCV_VERSION

COPY ./samples ./
COPY ./clean-samples.sh ./
COPY ./health-check.sh ./

WORKDIR /work

CMD [ "bash" ]
