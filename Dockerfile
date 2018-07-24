FROM resin/raspberry-pi3-buildpack-deps:jessie-scm

RUN apt-get update \
 && apt-get install build-essential

RUN git clone https://github.com/joan2937/pigpio \
 && cd pigpio \
 && make install prefix=/tmp/pigpio CFLAGS=-DEMBEDDED_IN_VM

#-------

FROM resin/raspberry-pi3-openjdk:8-jre

COPY --from=0 /tmp/pigpio/lib/* /usr/local/lib/

RUN ldconfig \
 && ldconfig -p | grep pigpio
