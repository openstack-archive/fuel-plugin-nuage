#!/usr/bin/env bash

source ~/openrc

neutron net-list
if [ "$?" = "0" ]; then
        echo "Neutron successfully started with Nuage Plugin"
        exit 0
else
        echo "Neutron failed to start with Nuage Plugin"
        exit 1
fi
