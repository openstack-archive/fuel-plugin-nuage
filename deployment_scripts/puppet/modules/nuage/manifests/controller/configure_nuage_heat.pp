# Install and configure Nuage heat extensions

class nuage::controller::configure_nuage_heat {

  include ::nuage::params

  package { $::nuage::params::nuage_openstack_heat:
    ensure => present,
  } ->

  file { '/etc/heat/heat.conf':
    ensure => present,
  } ->

  ini_setting { 'Nuage Heat Configuration':
    ensure  => present,
    path    => '/etc/heat/heat.conf',
    section => 'DEFAULT',
    setting => 'plugin_dirs',
    value   => '/usr/lib/python2.7/dist-packages/nuage-heat/',
    notify  => Service['heat-engine'],
  }

  service { 'heat-engine':
    subscribe => File['/etc/heat/heat.conf'],
    ensure    => running,
  }
}
