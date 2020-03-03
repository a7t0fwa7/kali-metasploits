FROM kalilinux/kali@sha256:cac922c07ff789d4e70a0205e62094e12e2f78006115068e92aa0b2715efe213

RUN apt-get -y update
RUN apt-get -y install metasploit-framework net-tools ruby vim

#WORKDIR /usr/share/metasploit-framework
#RUN mkdir -p /usr/share/metasploit-framework/modules/exploits/custom
#COPY exploits/ /usr/share/metasploit-framework/modules/exploits/custom
