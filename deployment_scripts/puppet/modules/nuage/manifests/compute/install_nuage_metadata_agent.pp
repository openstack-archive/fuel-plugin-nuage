# Install nuage metadata agent packages

class nuage::compute::install_nuage_metadata_agent {
 
  include ::nuage::params
 
  package { $::nuage::params::python_novaclient:
    ensure => present,
  }

  package { $::nuage::params::nuage_metadata_agent:
    ensure  => present,
    require => Package[$::nuage::params::python_novaclient]
  } ->
  file { '/etc/default/nuage-metadata-agent':
    content => template('nuage/nuage-metadata-agent.erb'),
    notify  => Service[$::nuage::params::nuage_openvswitch_switch],
  }

  service { $::nuage::params::nuage_openvswitch_switch:
    subscribe => File['/etc/default/nuage-metadata-agent'],
  }
}
