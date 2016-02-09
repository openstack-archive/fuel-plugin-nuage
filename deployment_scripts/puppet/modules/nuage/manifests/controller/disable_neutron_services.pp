# Disable non-essential neutron services
class nuage::controller::disable_neutron_services {

  include ::nuage::params

  service { $::nuage::params::neutron_dhcp_agent:
    ensure => 'stopped'
  }

  service { $::nuage::params::neutron_l3_agent:
    ensure => 'stopped'
  }

  service { $::nuage::params::neutron_metadata_agent:
    ensure => 'stopped'
  }

  service { $::nuage::params::neutron_plugin_openvswitch_agent:
    ensure => 'stopped'
  }

  service { $::nuage::params::openvswitch_switch:
    ensure => 'stopped'
  }
}
