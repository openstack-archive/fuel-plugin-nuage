# Nova parameters for Nuage

class nuage::controller::nova (
  $firewall_driver,
  $security_group_api,
  $libvirt_vif_driver,
  $neutron_ovs_bridge,
) {

  include ::nuage::params

  service { $::nuage::params::nova_api:
    ensure => running,
    enable => true,
  }

  service { $::nuage::params::nova_scheduler:
    ensure => running,
    enable => true,
  }

  service { $::nuage::params::nova_conductor:
    ensure => running,
    enable => true,
  }

  Nova_config<||> ~> Service[$::nuage::params::nova_api,
    $::nuage::params::nova_scheduler,
    $::nuage::params::nova_conductor]

  #Setting nova.conf parameters on all Openstack nodes
  nova_config {
    'DEFAULT/firewall_driver': value => $firewall_driver;
    'DEFAULT/security_group_api': value => $security_group_api;
    'DEFAULT/libvirt_vif_driver' : value => $libvirt_vif_driver;
    'DEFAULT/use_forwarded_for' : value => 'True';
    'DEFAULT/instance_name_template' : value => 'inst-%08x';
    'DEFAULT/metadata_listen_port' : value => $nuage::nova_metadata_port;
    'neutron/ovs_bridge' : value => $neutron_ovs_bridge;
    'neutron/service_metadata_proxy' : value => 'True';
  }
}
