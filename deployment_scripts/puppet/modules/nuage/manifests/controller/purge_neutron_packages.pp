# Purge non-essential neutron packages

class nuage::controller::purge_neutron_packages {

  include ::nuage::params

  package { $::nuage::params::neutron_dhcp_agent:
    ensure => 'purged'
  }

  package { $::nuage::params::neutron_l3_agent:
    ensure => 'purged'
  }

  package { $::nuage::params::neutron_metadata_agent:
    ensure => 'purged'
  }

  package { $::nuage::params::neutron_plugin_openvswitch_agent:
    ensure => 'purged'
  }

  package { $::nuage::params::openvswitch_switch:
    ensure => 'purged'
  }
}
