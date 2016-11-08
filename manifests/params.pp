# ==Class: oslo::params
#
# Parameters for puppet-oslo
#
class oslo::params {
  include ::openstacklib::defaults

  $pymongo_package_name = 'python-pymongo'
  $pylibmc_package_name = 'python-pylibmc'

  case $::osfamily {
    'RedHat': {
      $sqlite_package_name          = undef
      $pymysql_package_name         = undef
      $python_memcache_package_name = 'python-memcached'
    }
    'Debian': {
      $sqlite_package_name          = 'python-pysqlite2'
      $pymysql_package_name         = 'python-pymysql'
      $python_memcache_package_name = 'python-memcache'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily
}
