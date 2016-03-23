# OS specific parameters for the nuage plugin

class nuage::params {

    if ($::osfamily == 'Redhat') {

        $nova_api = 'nova-api'
        $nova_scheduler = 'nova-scheduler'
        $nova_conductor = 'nova-conductor'
        $nova_compute = 'nova-compute'

        $neutron_dhcp_agent = 'neutron-dhcp-agent'
        $neutron_l3_agent = 'neutron-l3-agent'
        $neutron_metadata_agent = 'neutron-metadata-agent'
        $neutron_plugin_openvswitch_agent = 'neutron-openvswitch-agent'
        $neutron_server = 'neutron-server'
        $openvswitch_switch = 'openvswitch'

        $python_novaclient = 'python-novaclient'
        $python_twisted = 'python-twisted'

        $nuage_neutron  = 'nuage-neutron'
        $nuage_metadata_agent = 'nuage-metadata-agent'
        $nuage_openstack_neutronclient = 'nuage-openstack-neutronclient'
        $nuage_python_nuagenetlib = 'nuagenetlib'
        $nuage_openvswitch_switch = 'nuage-openvswitch'
    } elsif($::osfamily == 'Debian') {

        $nova_api = 'nova-api'
        $nova_scheduler = 'nova-scheduler'
        $nova_conductor = 'nova-conductor'
        $nova_compute = 'nova-compute'

        $neutron_dhcp_agent = 'neutron-dhcp-agent'
        $neutron_l3_agent = 'neutron-l3-agent'
        $neutron_metadata_agent = 'neutron-metadata-agent'
        $neutron_plugin_openvswitch_agent = 'neutron-plugin-openvswitch-agent'
        $neutron_server = 'neutron-server'
        $openvswitch_switch = 'openvswitch-switch'

        $python_novaclient = 'python-novaclient'
        $python_twisted = 'python-twisted'

        $nuage_neutron  = 'nuage-openstack-neutron'
        $nuage_openstack_horizon = 'nuage-openstack-horizon'
        $nuage_openstack_heat = 'nuage-openstack-heat'
        $nuage_metadata_agent = 'nuage-metadata-agent'
        $nuage_openstack_neutronclient = 'nuage-openstack-neutronclient'
        $nuage_python_nuagenetlib = 'nuagenetlib'
        $nuage_openvswitch_switch = 'nuage-openvswitch-switch'
    }
}
