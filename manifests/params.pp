# ==Class: oslo::params
#
# Parameters for puppet-oslo
#
class oslo::params {
  include openstacklib::defaults
  $pyvers = $::openstacklib::defaults::pyvers

  $pymongo_package_name = "python${pyvers}-pymongo"
  $pylibmc_package_name = "python${pyvers}-pylibmc"

  case $::osfamily {
    'RedHat': {
      $sqlite_package_name            = undef
      $pymysql_package_name           = undef
      $python_memcache_package_name   = "python${pyvers}-memcached"
      $python_redis_package_name      = "python${pyvers}-redis"
      $python_etcd3gw_package_name    = "python${pyvers}-etcd3gw"
      $python_etcd3_package_name      = undef
      $python_pymemcache_package_name = "python${pyvers}-pymemcache"
    }
    'Debian': {
      $sqlite_package_name            = "python${pyvers}-pysqlite2"
      $pymysql_package_name           = "python${pyvers}-pymysql"
      $python_memcache_package_name   = "python${pyvers}-memcache"
      $python_redis_package_name      = "python${pyvers}-redis"
      $python_etcd3gw_package_name    = "python${pyvers}-etcd3gw"
      $python_etcd3_package_name      = "python${pyvers}-etcd3"
      $python_pymemcache_package_name = "python${pyvers}-pymemcache"
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, \
module ${module_name} only support osfamily RedHat and Debian")
    }

  } # Case $::osfamily
}
