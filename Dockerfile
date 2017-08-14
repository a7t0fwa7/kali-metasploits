FROM kalilinux/kali-linux-docker@sha256:2ebc75f51fa4937340a0d3b4fe903c60aad23866b8c9e1fae80ad7372e01b71d

RUN apt-get -y update
RUN apt-get -y install ruby vim metasploit-framework

WORKDIR /usr/share/metasploit-framework
RUN mkdir -p /usr/share/metasploit-framework/modules/exploits/custom
COPY exploits/ /usr/share/metasploit-framework/modules/exploits/custom
