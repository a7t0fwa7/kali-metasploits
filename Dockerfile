FROM kalilinux/kali-linux-docker@sha256:ddb33d548851d58a5ac351ac5ad3579fb7af5c6e17d7b70bbf49102d9865a1a3

RUN apt-get -y update
RUN apt-get -y install ruby vim metasploit-framework

#WORKDIR /usr/share/metasploit-framework
#RUN mkdir -p /usr/share/metasploit-framework/modules/exploits/custom
#COPY exploits/ /usr/share/metasploit-framework/modules/exploits/custom
