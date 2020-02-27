FROM kalilinux/kali

RUN apt-get -y update
RUN apt-get -y install metasploit-framework net-tools ruby vim

#WORKDIR /usr/share/metasploit-framework
#RUN mkdir -p /usr/share/metasploit-framework/modules/exploits/custom
#COPY exploits/ /usr/share/metasploit-framework/modules/exploits/custom
