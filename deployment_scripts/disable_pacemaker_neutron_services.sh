#!/bin/bash

crm resource stop p_neutron-metadata-agent
crm configure delete p_neutron-metadata-agent

crm resource stop p_neutron-dhcp-agent
crm configure delete p_neutron-dhcp-agent

crm resource stop  p_neutron-l3-agent
crm configure delete  p_neutron-l3-agent
