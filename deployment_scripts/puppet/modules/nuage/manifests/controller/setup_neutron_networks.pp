class nuage::controller::setup_neutron_networks {

 include ::nuage::params

 $neutron_settings      = hiera('quantum_settings')
 $external_net_name     = $neutron_settings['default_floating_net']
 $tenant_net_name       = $neutron_settings['default_private_net']
 $predefined_nets       = $neutron_settings['predefined_networks']
 $tenant_net            = $predefined_nets[$tenant_net_name]
 $external_net          = $predefined_nets[$external_net_name]

 service { 'neutron-server':
  ensure => running,
 }

 neutron_network { $tenant_net_name:
  ensure                    => present,
  router_external           => $tenant_net['L2']['router_ext'],
  tenant_name               => $tenant_net['tenant'],
  shared                    => $tenant_net['shared']
 } ->

 neutron_subnet { "${tenant_net_name}__subnet":
  ensure          => present,
  cidr            => $tenant_net['L3']['subnet'],
  network_name    => $tenant_net_name,
  tenant_name     => $tenant_net['tenant'],
  gateway_ip      => $tenant_net['L3']['gateway'],
  enable_dhcp     => $tenant_net['L3']['enable_dhcp'],
  dns_nameservers => $tenant_net['L3']['nameservers']
 } ->

 neutron_network { $external_net_name:
  ensure                    => present,
  router_external           => $external_net['L2']['router_ext'],
  tenant_name               => $external_net['tenant'],
  shared                    => $external_net['shared']
 } ->

 neutron_subnet { "${external_net_name}__subnet":
  ensure           => present,
  cidr             => $external_net['L3']['subnet'],
  network_name     => $external_net_name,
  tenant_name      => $external_net['tenant'],
  gateway_ip       => $external_net['L3']['gateway'],
  enable_dhcp      => $external_net['L3']['enable_dhcp'],
  dns_nameservers  => $external_net['L3']['nameservers']
  # allocation_pools => $allocation_pools
 } ->

 neutron_router { 'nuage_router':
  ensure               => present,
  tenant_name          => $external_net['tenant'],
  gateway_network_name => $external_net_name,
 } ->

 neutron_router_interface { "nuage_router:${tenant_net_name}__subnet":
  ensure => present,
 }
}

