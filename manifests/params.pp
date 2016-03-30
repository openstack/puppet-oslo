# Parameters for puppet-oslo
#
class oslo::params {

  case $::osfamily {
    'RedHat': {
      $sqlite_package_name  = undef
      $pymysql_package_name = undef
      $pymongo_package_name = 'python-pymongo'
    }
    'Debian': {
      $sqlite_package_name  = 'python-pysqlite2'
      $pymysql_package_name = 'python-pymysql'
      $pymongo_package_name = 'python-pymongo'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily
}
