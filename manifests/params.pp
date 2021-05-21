# ==Class: oslo::params
#
# Parameters for puppet-oslo
#
class oslo::params {
  include openstacklib::defaults

  $pymongo_package_name = 'python3-pymongo'
  $pylibmc_package_name = 'python3-pylibmc'

  case $::osfamily {
    'RedHat': {
      $sqlite_package_name            = undef
      $pymysql_package_name           = undef
      $python_memcache_package_name   = 'python3-memcached'
      $python_redis_package_name      = 'python3-redis'
      $python_etcd3gw_package_name    = 'python3-etcd3gw'
      $python_etcd3_package_name      = undef
      $python_pymemcache_package_name = 'python3-pymemcache'
    }
    'Debian': {
      $sqlite_package_name            = 'python3-pysqlite2'
      $pymysql_package_name           = 'python3-pymysql'
      $python_memcache_package_name   = 'python3-memcache'
      $python_redis_package_name      = 'python3-redis'
      $python_etcd3gw_package_name    = 'python3-etcd3gw'
      $python_etcd3_package_name      = 'python3-etcd3'
      $python_pymemcache_package_name = 'python3-pymemcache'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, \
module ${module_name} only support osfamily RedHat and Debian")
    }

  } # Case $::osfamily
}
