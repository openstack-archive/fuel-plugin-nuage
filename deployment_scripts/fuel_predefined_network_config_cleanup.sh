set -x

ROUTER=router04

EXTERNAL_NW=net04_ext
EXTERNAL_SUBNET=net04_ext__subnet

TENANT_NW=net04
TENANT_SUBNET=net04__subnet

source ~/openrc

EXT_NET_ID=$(neutron net-list | grep $EXTERNAL_NW | awk '{print $2;}')
neutron router-gateway-clear $ROUTER $EXT_NET_ID

neutron subnet-delete $EXTERNAL_SUBNET
neutron net-delete $EXTERNAL_NW

TENANT_SUBNET_ID=$(neutron subnet-list | grep $TENANT_SUBNET | awk '{print $2}')
neutron router-interface-delete $ROUTER $TENANT_SUBNET_ID

port_id_list=$(neutron port-list | grep $TENANT_SUBNET_ID | awk '{print $2}')

for port_id in $port_id_list
do
 (neutron port-delete $port_id) & sleep 10 ; kill $!
done

neutron subnet-delete $TENANT_SUBNET
neutron net-delete $TENANT_NW

neutron router-delete $ROUTER

if [[ $(neutron port-list | grep $TENANT_SUBNET_ID | awk '{print $2}') ]]; then
    echo "Fuel pre-defined vports exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined vports successfully cleaned up on Controller nodes"
fi

if [[ $(neutron subnet-list | grep $TENANT_SUBNET | awk '{print $2}') ]]; then
    echo "Fuel pre-defined tenant subnet exists on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined tenant subnet successfully cleaned up on Controller nodes"
fi

if [[ $(neutron subnet-list | grep $EXTERNAL_SUBNET | awk '{print $2}') ]]; then
    echo "Fuel pre-defined external subnet exists on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined external subnet successfully cleaned up on Controller nodes"
fi

if [[ $(neutron net-list | grep $EXTERNAL_NW | awk '{print $2;}') ]]; then
    echo "Fuel pre-defined external network exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined external network successfully cleaned up on Controller nodes"
fi

if [[ $(neutron net-list | grep $TENANT_NW | awk '{print $2;}') ]]; then
    echo "Fuel pre-defined tenant network exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined tenant network successfully cleaned up on Controller nodes"
fi

if [[ $(neutron router-list | grep $ROUTER ) ]]; then
    echo "Fuel pre-defined router exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined router successfully cleaned up on Controller nodes"
fi

if [[ "$cleanup" == "False" ]]; then
    echo "Cleanup of pre-defined Fuel network configuration on Controller nodes failed"
    exit 1
else
    echo "Cleanup of pre-defined Fuel network configuration on Controller nodes succeeded"
fi
