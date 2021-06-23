#----------------------------------------------------------
# This script adds new ip route, if there isn't one already
#---------------------------------------------------------

#!/bin/bash

HOST=192.168.7.1

DATE=`date`
PINGRES=`ping -c 2 $HOST`
PLOSS=`echo $PINGRES : | grep -oP '\d+(?=% packet loss)'`
echo "$DATE : Loss Result : $PLOSS"

if [ "100" -eq "$PLOSS" ];
then
    echo "$DATE : Starting : $HOST"
    sudo pppd call linuxconfig
    echo "$DATE : Now running : $HOST"
    sleep 20
    sudo ip route add 192.168.7.0/24 via 192.168.7.1 dev ppp0
else
    echo "$DATE : Already running : $HOST"
fi 
