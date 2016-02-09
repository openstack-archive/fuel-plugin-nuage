$hiera_dir = '/etc/hiera/override'
$plugin_name = 'nuage-openstack-fuel-plugin'
$plugin_yaml = "${plugin_name}.yaml"

file {'/etc/hiera/override':
  ensure  => directory,
} ->

file { "${hiera_dir}/${plugin_yaml}":
  ensure  => file,
  content => template('nuage/compute.plugins.yaml.erb'),
  require => File['/etc/hiera/override']
} ->

file_line {"${plugin_name}_hiera_override":
  path  => '/etc/hiera.yaml',
  line  => "  - override/${plugin_name}",
  after => '  - override/module/%{calling_module}',
}
