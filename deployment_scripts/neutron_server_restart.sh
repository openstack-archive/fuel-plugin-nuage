#!/usr/bin/env bash

service neutron-server start
server_restart_count=0

while [ $server_restart_count -lt 10 ]
do
   source ~/openrc
   neutron net-list
   if [ "$?" = "0" ]; then
        echo "Neutron successfully started with Nuage Plugin"
        break
   fi
   echo "Restarting neutron-server service"
   service neutron-server restart
   sleep 20
   server_restart_count=`expr $server_restart_count + 1`
done
