# Install Nuage neutron packages

class nuage::controller::install_nuage_neutron {

  include ::nuage::params

  package { $::nuage::params::nuage_neutron:
    ensure => present,
  }

  package { $::nuage::params::nuage_openstack_neutronclient:
    ensure => present,
  }

  package { $::nuage::params::nuage_python_nuagenetlib:
    ensure => present,
  }
}
