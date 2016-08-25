# Perform Nuage DB sync

class nuage::controller::nuage_db_sync {

  exec { 'nuage-neutron-stop':
    command     => 'service neutron-server stop',
    path        => '/usr/bin',
  } ->

  exec { 'nuage-neutron-db-sync':
    command     => 'neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugin.ini upgrade head',
    path        => '/usr/bin',
    logoutput   => true,
  }
}
