# Parameters for configuring Nuage Fuel plugin
class nuage {

$settings = hiera('nuage-openstack-fuel-plugin')
$nova_settings=hiera('nova')
$neutron_settings=hiera_hash('quantum_settings', {})
$nova_auth_ip=hiera('management_vip')

$net_partition_name = $settings['nuage_net_partition_name']
$vsd_ip = $settings['nuage_vsd_ip']
$vsd_username = $settings['nuage_vsd_username']
$vsd_password = $settings['nuage_vsd_password']
$vsd_organization = $settings['nuage_vsd_organization']
$base_uri_version = $settings['nuage_base_uri_version']
$active_controller =  $settings['nuage_active_vsc_ip']
$backup_controller =  $settings['nuage_backup_vsc_ip']

## Metadata settings
$metadata_port = $settings['metadata_port']
$nova_metadata_port = $settings['nova_metadata_port']
$nova_region_name = $settings['nova_region_name']
$nova_api_endpoint_type = $settings['nova_api_endpoint_type']
$metadata_secret=$neutron_settings['metadata']['metadata_proxy_shared_secret']
$nova_os_password = $nova_settings['user_password']
$nova_client_version = '2'
$nova_os_username = 'nova'
$nova_os_tenant_name = 'services'
$metadata_agent_start_with_ovs = 'true'

$nuage_cms_id = $settings['nuage_cms_id']
$pat_to_underlay = $settings['pat_to_underlay']
$network_uplink_intf = $settings['pat_to_underlay_uplink_intf']
}
