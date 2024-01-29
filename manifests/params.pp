# ==Class: oslo::params
#
# Parameters for puppet-oslo
#
class oslo::params {
  include openstacklib::defaults

  $pylibmc_package_name = 'python3-pylibmc'

  case $facts['os']['family'] {
    'RedHat': {
      $pymysql_package_name           = undef
      $python_memcache_package_name   = 'python3-memcached'
      $python_redis_package_name      = 'python3-redis'
      $python_etcd3gw_package_name    = 'python3-etcd3gw'
      $python_pymemcache_package_name = 'python3-pymemcache'
      $oslo_reports_package_name      = 'python3-oslo-reports'
    }
    'Debian': {
      $pymysql_package_name           = 'python3-pymysql'
      $python_memcache_package_name   = 'python3-memcache'
      $python_redis_package_name      = 'python3-redis'
      $python_etcd3gw_package_name    = 'python3-etcd3gw'
      $python_pymemcache_package_name = 'python3-pymemcache'
      $oslo_reports_package_name      = 'python3-oslo.reports'
    }
    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}")
    }

  } # Case $facts['os']['family']
}
