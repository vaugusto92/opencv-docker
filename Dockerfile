FROM alpine:latest

ENV VERSION=4.4.0
ENV LANG=C.UTF-8

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
RUN chmod +x opencv.sh && ./opencv.sh $VERSION

COPY ./samples ./
COPY ./clean_samples.sh ./

WORKDIR /work

CMD [ "bash" ]
