# Install and configure Nuage horizon

class nuage::controller::configure_nuage_horizon {

  include ::nuage::params

  package { $::nuage::params::nuage_openstack_horizon:
    ensure => present,
  }

  service { 'apache2':
    subscribe => File['/etc/apache2/conf-available/openstack-dashboard.conf'],
  }

  service { $::nuage::params::neutron_server:
    subscribe => File['/etc/apache2/conf-available/openstack-dashboard.conf'],
  }

  file_line { 'Update customization_module parameter in the dashboard local_settings.py':
    ensure => present,
    line   => "    'customization_module': 'nuage_horizon.customization',",
    after => "               'unauthorized': exceptions.UNAUTHORIZED},",
    path   => '/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.py',
    require => Package[$::nuage::params::nuage_openstack_horizon],
  } ->

  file_line { 'Update the modal_backdrop parameter in dashboard local_settings.py':
    ensure => present,
    line   => "    'modal_backdrop': 'static',",
    after => "'customization_module': 'nuage_horizon.customization',",
    path   => '/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.py',
  } ->

  file_line { 'Set dashboards parameter to null in dashboard local_settings.py':
    path    => '/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.py',
    match   => "'dashboards':",
    line    => "    'dashboard': (),",
  } ->

  file_line { 'Set default dashboard parameter to null in dashboard local_settings.py':
    path    => '/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.py',
    match   => "'default_dashboard':",
    line    => "    'default_dashboard': '',",
  } ->

  file { '/etc/apache2/conf-available/openstack-dashboard.conf':
    content => template('nuage/openstack-dashboard.conf.erb'),
    notify  => Service['apache2', $::nuage::params::neutron_server],
  }
}
