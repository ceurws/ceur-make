# Use Ubuntu 20.04 LTS version
# inspired by https://github.com/blang/latex-docker/blob/master/Dockerfile.ubuntu
FROM ubuntu:focal

MAINTAINER Wolfgang Fahl <wf@bitplan.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install -qy \
    texlive-full \
    python-pygments gnuplot \
    make git rcs vim


WORKDIR /usr/local/src
RUN git clone https://github.com/ceurws/ceur-make

WORKDIR /data
VOLUME ["/data"]
