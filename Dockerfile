FROM ubuntu:bionic-20200403
MAINTAINER Richard Yu <xiaoqingfengatgm@gmail.com>
# https://github.com/xiaoqingfengATGH/strongswanDocker
# version: 1.1
WORKDIR /root
RUN apt-get update \
	&& apt-get install -y \
	curl \
	gawk \
	make \
	pkg-config \
	libip4tc-dev \
	m4 \
	iptables \
	&& groupadd vpn \
	&& cd /root \
    && curl -OSL https://github.com/xiaoqingfengATGH/strongswanDocker/raw/master/gmp-6.2.0.tar \
	&& curl -OSL https://github.com/xiaoqingfengATGH/strongswanDocker/raw/master/iptables-1.6.1.tar \
	&& curl -OSL https://github.com/xiaoqingfengATGH/strongswanDocker/raw/master/strongswan-5.8.4.tar.gz \
	&& tar -xvf gmp-6.2.0.tar \
	&& cd /root/gmp-6.2.0 \
	&& ./configure \
	&& make \
	&& make install \
	&& cd /root \
	&& tar -xvf iptables-1.6.1.tar \
	&& mkdir -p /usr/local/include/libiptc \
	&& cp ./iptables-1.6.1/include/libiptc/ipt_kernel_headers.h /usr/local/include/libiptc/ \
	&& cp ./iptables-1.6.1/include/libiptc/libiptc.h /usr/local/include/libiptc/ \
	&& cp ./iptables-1.6.1/include/libiptc/xtcshared.h /usr/local/include/libiptc/ \
	&& cd /root \
	&& tar xzvf strongswan-5.8.4.tar.gz \
	&& cd strongswan-5.8.4 \
	&& ./configure --prefix=/usr --sysconfdir=/etc --enable-connmark --enable-dhcp --enable-eap-mschapv2 --enable-farp --enable-md4 \
	--enable-eap-identity --enable-eap-dynamic --enable-xauth-eap \
	&& make install \
	&& cd /root \
	&& rm -rf gmp-6.2.0 \
	&& rm -f gmp-6.2.0.tar \
	&& rm -rf iptables-1.6.1 \
	&& rm -rf iptables-1.6.1.tar \
	&& rm -rf strongswan-5.8.4 \
	&& rm -rf strongswan-5.8.4.tar.gz \
	&& apt-get clean \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*
	
RUN rm /etc/ipsec.secrets \
    && mkdir -p /etc/ipsec.d/conf && touch /etc/ipsec.d/conf/placeholder.conf \
	&& echo "include /etc/ipsec.d/conf/*.conf" >> /etc/ipsec.conf \
	&& rm -rf /etc/strongswan.d

ADD ipsec_start /usr/local/bin/ipsec_start
ADD pipework /usr/local/bin/pipework

VOLUME /etc/ipsec.d

EXPOSE 4500/udp 500/udp

ENTRYPOINT ["bash","/usr/local/bin/ipsec_start"]
CMD []