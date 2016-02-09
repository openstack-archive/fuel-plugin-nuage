# Nova parameters for Nuage

class nuage::compute::nova (
  $firewall_driver,
  $security_group_api,
  $libvirt_vif_driver,
  $neutron_ovs_bridge,
) {

  include ::nuage::params

  service { $::nuage::params::nova_compute:
    ensure => running,
    enable => true,
  }

  Nova_config<||> ~> Service[$::nuage::params::nova_compute]

  #Setting nova.conf parameters on all Openstack nodes
  nova_config {
    'DEFAULT/firewall_driver': value => $firewall_driver;
    'DEFAULT/security_group_api': value => $security_group_api;
    'DEFAULT/libvirt_vif_driver' : value => $libvirt_vif_driver;
    'neutron/ovs_bridge' : value => $neutron_ovs_bridge;
  }
}
