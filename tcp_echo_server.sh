#!/bin/bash

# Local host IP address
LHOST=$(ifconfig en1 | grep "inet " | awk '{print $2}')
if [[ "$LHOST" == "" ]]; then
  LHOST=$(ifconfig en0 | grep "inet " | awk '{print $2}')
fi
LPORT=5555

# Remote host is the local host for development
RHOST=$LHOST

docker run -it -p 5555:5555 -v $PWD/exploits:/usr/share/metasploit-framework/modules/exploits/custom polyverse-internal.jfrog.io/kali-metasploit msfconsole -x "use exploit/custom/tcp_echo_server.rb; set RHOST $RHOST; set LHOST $LHOST"
