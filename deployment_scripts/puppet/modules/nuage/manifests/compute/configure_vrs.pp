# Configure the VRS on compute
class nuage::compute::configure_vrs {

  include ::nuage::params

  package { $::nuage::params::openvswitch_switch:
    ensure => 'purged',
  } ->
  package { $::nuage::params::python_twisted:
    ensure  => 'present',
  } ->
  package { $::nuage::params::nuage_openvswitch_switch:
    ensure  => 'present',
    require => Package[$::nuage::params::openvswitch_switch]
  }

  file { '/etc/default/openvswitch-switch':
    require => Package[$::nuage::params::nuage_openvswitch_switch],
    notify  => Service[$::nuage::params::nuage_openvswitch_switch]
  }

  File_line<||> ~> Service[$::nuage::params::nuage_openvswitch_switch]
  File['/etc/default/openvswitch-switch'] -> File_line<||>

  service { $::nuage::params::nuage_openvswitch_switch:
    ensure    => 'running',
    require   => Package[$::nuage::params::nuage_openvswitch_switch],
    subscribe => File['/etc/default/openvswitch-switch'],
  }

  file_line { 'openvswitch active controller ip address':
    ensure => present,
    line   => "ACTIVE_CONTROLLER=${nuage::active_controller}",
    match  => 'ACTIVE_CONTROLLER=',
    path   => '/etc/default/openvswitch-switch',
  }

  if $::nuage::backup_controller {
    file_line { 'openvswitch backup controller ip address':
      ensure => present,
      line   => "STANDBY_CONTROLLER=${nuage::backup_controller}",
      match  => 'STANDBY_CONTROLLER=',
      path   => '/etc/default/openvswitch-switch',
    }
  }

  if $::nuage::pat_to_underlay {
    file_line { 'openvswitch uplink interface for pat to underlay':
      ensure => present,
      line   => "NETWORK_UPLINK_INTF=${nuage::network_uplink_intf}",
      match  => 'NETWORK_UPLINK_INTF=',
      path   => '/etc/default/openvswitch-switch',
    }
  }
}
