# == Define: oslo::coordination
#
# Setup and configure coordination settings.
#
# === Parameters
#
# [*backend_url*]
#   (Optional) Coordination backend URL.
#   Defaults to $facts['os_service_default']
#
# [*manage_backend_package*]
#   (Optional) Whether to install the backend package.
#   Defaults to true.
#
# [*package_ensure*]
#   (Optional) ensure state for package.
#   Defaults to 'present'
#
# [*manage_config*]
#   (Optional) Whether to manage the configuration parameters.
#   Defaults to true.
#
define oslo::coordination (
  $backend_url            = $facts['os_service_default'],
  $manage_backend_package = true,
  $package_ensure         = 'present',
  $manage_config          = true,
) {

  include oslo::params

  validate_legacy(Boolean, 'validate_bool', $manage_backend_package)
  validate_legacy(Boolean, 'validate_bool', $manage_config)

  if $manage_backend_package and !is_service_default($backend_url){
    case $backend_url {
      /^redis:\/\//: {
        ensure_packages('python-redis', {
          name   => $::oslo::params::python_redis_package_name,
          ensure => $package_ensure,
          tag    => 'openstack',
        })
      }
      /^etcd3\+http[s]?:\/\//: {
        ensure_packages('python-etcd3gw', {
          name   => $::oslo::params::python_etcd3gw_package_name,
          ensure => $package_ensure,
          tag    => 'openstack',
        })
      }
      /^etcd3:\/\//: {
        warning('Support for the etcd3 driver has been deprecated.')
        if $::oslo::params::python_etcd3_package_name {
          ensure_packages('python-etcd3', {
            name   => $::oslo::params::python_etcd3_package_name,
            ensure => $package_ensure,
            tag    => 'openstack',
          })
        } else {
          warning('The python-etcd3 package is not available.')
        }
      }
      /^memcached:\/\//: {
        ensure_packages('python-pymemcache', {
          name   => $::oslo::params::python_pymemcache_package_name,
          ensure => $package_ensure,
          tag    => 'openstack',
        })
      }
      default: {
        # Nothing to do
      }
    }
  }

  if $manage_config {
    $coordination_options = {
      'coordination/backend_url' => { value => $backend_url },
    }
    create_resources($name, $coordination_options)
  }
}
