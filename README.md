TCP-32764-First-Aid
===================

First aid for disabling the TCP-32764 backdoor in some routers


First router: ./wag120n.sh

 _____ _          _        _    _     _ 
|  ___(_)_ __ ___| |_     / \  (_) __| |
| |_  | | '__/ __| __|   / _ \ | |/ _` |
|  _| | | |  \__ \ |_   / ___ \| | (_| |
|_|   |_|_|  |___/\__| /_/   \_\_|\__,_|
                                        
 This is TCP-32764-First-Aid (WAG120N)

 It tries to run 'killall server_daemon'
 on your router, disabling the backdoor.
 Everything happens in RAM and this isn't
 a permanent solution.


wag120n.sh [-h] [-i IP -u user -p password] -- small script to disable the 32764 backdoor in Linksys WAG120N (and maybe other too)

where:
    -h  show this help text
    -i  router IP address / host
    -u  admin user for the web management
    -p  admin password for the web management


More
====

Please contribute more routers / fixes!
