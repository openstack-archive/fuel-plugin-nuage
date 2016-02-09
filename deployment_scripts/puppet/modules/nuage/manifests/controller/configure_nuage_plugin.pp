# Configure Nuage neutron plugin

class nuage::controller::configure_nuage_plugin {

  include ::nuage::params

  service { $::nuage::params::neutron_server:
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/neutron/plugin.ini']
  }

  package { $::nuage::params::nuage_neutron:
    ensure => present,
  } ->
  file { '/etc/neutron/plugins/nuage':
    ensure => directory,
    owner  => 'root',
    group  => 'neutron',
    mode   => '0640'
  } ->
  file { '/etc/neutron/plugins/nuage/plugin.ini':
    ensure  => 'present',
    require => File['/etc/neutron/plugins/nuage'],
    content => template('nuage/plugin.ini.erb'),
  } ->
  file {'/etc/neutron/plugin.ini':
    ensure  => link,
    target  => '/etc/neutron/plugins/nuage/plugin.ini',
    require => Package[$::nuage::params::nuage_neutron],
    notify  => Service[$::nuage::params::neutron_server]
  }

  if $::nuage::pat_to_underlay {
    file_line { 'config flag in nuage plugin file for pat to underlay':
      ensure => present,
      line   => "nuage_pat = default_enabled",
      match  => 'nuage_pat =',
      path   => '/etc/neutron/plugins/nuage/plugin.ini',
      require => File['/etc/neutron/plugins/nuage/plugin.ini'],
      notify  => Service[$::nuage::params::neutron_server]
    }
  }
}
