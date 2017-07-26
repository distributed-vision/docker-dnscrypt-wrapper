FROM ubuntu:trusty

MAINTAINER Meng Bo "mengbo@lnu.edu.cn"

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ wily-security main" > /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ wily main" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y -f --no-install-recommends install curl libcurl4-gnutls-dev git autoconf automake libevent-dev build-essential
RUN apt-get install -y ca-certificates

RUN mkdir -p /usr/local/src;\
  cd /usr/local/src;\
  curl https://download.libsodium.org/libsodium/releases/libsodium-1.0.13.tar.gz | tar xz;\
  cd libsodium*;\
  ./configure;\
  make && make check;\
  make install

RUN echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf;\
  ldconfig;

RUN mkdir -p /usr/local/src;\
  cd /usr/local/src;\
  git clone --progress --recursive -b client_key_check git://github.com/distributed-vision/dnscrypt-wrapper.git;\
  cd dnscrypt-wrapper;\
  make configure;\
  ./configure;\
  make install

ADD run.sh /run.sh
RUN chmod +x /run.sh

VOLUME ["/usr/local/share/dnscrypt-wrapper"]

EXPOSE 443
EXPOSE 443/udp

CMD ["/run.sh"]
