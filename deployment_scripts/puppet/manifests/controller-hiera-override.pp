$hiera_dir = '/etc/hiera/plugins'
$plugin_name = 'nuage-openstack-fuel-plugin'
$plugin_yaml = "${plugin_name}.yaml"

file {'/etc/hiera/plugins':
  ensure  => directory,
} ->

file { "${hiera_dir}/${plugin_yaml}":
  ensure  => file, 
  content => 'neutron_config: { predefined_networks: [] }',
}
