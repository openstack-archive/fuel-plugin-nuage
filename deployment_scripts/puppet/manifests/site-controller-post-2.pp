include nuage

class { 'nuage::controller::set_nuage_core_plugin':
  core_plugin     => 'neutron.plugins.nuage.plugin.NuagePlugin',
  service_plugins => '',
}
