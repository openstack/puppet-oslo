# == Define: oslo::db
#
# Configure oslo_db options
#
# This resource configures Oslo database configs for an OpenStack service.
# It will manage the [database] section in the given config resource.
#
# === Parameters:
#
# [*config_group*]
#   (Optional) The configuration group to set the database configuration in.
#   Some OpenStack services might implement the oslo database options in another
#   configuration group, this makes it available to set which one to use.
#   Defaults to 'database'
#
# [*sqlite_synchronous*]
#   (Optional) If True, SQLite uses synchronous mode (boolean value).
#   Defaults to $::os_service_default
#
# [*backend*]
#   (Optional) The back end to use for the database.
#   Defaults to $::os_service_default
#
# [*manage_backend_package*]
#   (Optional) Whether to install the backend package.
#   Defaults to true.
#
# [*backend_package_ensure*]
#   (Optional) Desired ensure state of the backend database package,
#   accepts latest or specific versions.
#   Defaults to present.
#
# [*connection*]
#   (Optional) The SQLAlchemy connection string to use to connect to the database.
#   Defaults to $::os_service_default
#
# [*slave_connection*]
#   (Optional) The SQLAlchemy connection string to use to connect to the slave database.
#   Defaults to $::os_service_default
#
# [*mysql_sql_mode*]
#   (Optional) The SQL mode to be used for MySQL sessions.
#   Defaults to $::os_service_default
#
# [*connection_recycle_time*]
#   (Optional) Timeout before idle SQL connections are reaped.
#   Defaults to $::os_service_default
#
# [*min_pool_size*]
#   (Optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to $::os_service_default
#
# [*max_pool_size*]
#   (Optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to $::os_service_default
#
# [*max_retries*]
#   (Optional) Maximum number of database connection retries during startup.
#   Set to -1 to specify an infinite retry count.
#   Defaults to $::os_service_default
#
# [*retry_interval*]
#   (Optional) Interval between retries of opening a SQL connection.
#   Defaults to $::os_service_default
#
# [*max_overflow*]
#   (Optional) If set, use this value for max_overflow with SQLALchemy.
#   Defaults to $::os_service_default
#
# [*connection_debug*]
#   (Optional) Verbosity of SQL debugging information: 0=None, 100=Everything.
#   Defaults to $::os_service_default
#
# [*connection_trace*]
#   (Optional) Add Python stack traces to SQL as comment strings (boolean value).
#   Defaults to $::os_service_default
#
# [*pool_timeout*]
#   (Optional) If set, use this value for pool_timeout with SQLAlchemy.
#   Defaults to $::os_service_default
#
# [*use_db_reconnect*]
#   (Optional) Enable the experimental use of database reconnect on connection lost (boolean value)
#   Defaults to $::os_service_default
#
# [*db_retry_interval*]
#   (Optional) Seconds between retries of a database transaction.
#   Defaults to $::os_service_default
#
# [*db_inc_retry_interval*]
#   (Optional) If True, increases the interval between retries of
#   a database operation up to db_max_retry_interval.
#   Defaults to $::os_service_default
#
# [*db_max_retry_interval*]
#   (Optional) If db_inc_retry_interval is set, the maximum seconds between
#   retries of adatabase operation.
#   Defaults to $::os_service_default
#
# [*db_max_retries*]
#   (Optional) Maximum retries in case of connection error or deadlock error
#   before error is raised. Set to -1 to specify an infinite retry count.
#   Defaults to $::os_service_default
#
# [*use_tpool*]
#   (Optional) Enable the experimental use of thread pooling for all DB API calls (boolean value)
#   Defaults to $::os_service_default
#
# DEPRECATED PARAMETERS
#
# [*idle_timeout*]
#   (Optional) Timeout before idle SQL connections are reaped.
#   Defaults to undef
#
define oslo::db(
  $config_group            = 'database',
  $sqlite_synchronous      = $::os_service_default,
  $backend                 = $::os_service_default,
  $manage_backend_package  = true,
  $backend_package_ensure  = present,
  $connection              = $::os_service_default,
  $slave_connection        = $::os_service_default,
  $mysql_sql_mode          = $::os_service_default,
  $connection_recycle_time = $::os_service_default,
  $min_pool_size           = $::os_service_default,
  $max_pool_size           = $::os_service_default,
  $max_retries             = $::os_service_default,
  $retry_interval          = $::os_service_default,
  $max_overflow            = $::os_service_default,
  $connection_debug        = $::os_service_default,
  $connection_trace        = $::os_service_default,
  $pool_timeout            = $::os_service_default,
  $use_db_reconnect        = $::os_service_default,
  $db_retry_interval       = $::os_service_default,
  $db_inc_retry_interval   = $::os_service_default,
  $db_max_retry_interval   = $::os_service_default,
  $db_max_retries          = $::os_service_default,
  $use_tpool               = $::os_service_default,
  # DEPRCATED PARAMETERS
  $idle_timeout            = undef,
) {

  include ::oslo::params

  if !is_service_default($connection) {

    validate_legacy(Oslo::Dbconn, 'validate_re', $connection,
      ['^(sqlite|mysql(\+pymysql)?|postgresql(\+psycopg2)?|mongodb):\/\/(\S+:\S+@\S+\/\S+)?'])

    if $manage_backend_package {
      case $connection {
        /^mysql(\+pymysql)?:\/\//: {
          require '::mysql::bindings'
          require '::mysql::bindings::python'
          if $connection =~ /^mysql\+pymysql/ {
            $backend_package = $::oslo::params::pymysql_package_name
          } else {
            $backend_package = false
          }
        }
        /^postgresql(\+psycopg2)?:\/\//: {
          $backend_package = false
          require '::postgresql::lib::python'
        }
        /^mongodb:\/\//: {
          $backend_package = $::oslo::params::pymongo_package_name
        }
        /^sqlite:\/\//: {
          $backend_package = $::oslo::params::sqlite_package_name
        }
        default: {
          fail('Unsupported backend configured')
        }
      }

      if $backend_package and !defined(Package[$backend_package]) {
        package { $backend_package:
          ensure => $backend_package_ensure,
          name   => $backend_package,
          tag    => 'openstack',
        }
      }
    }
  }

  if $idle_timeout != undef {
    warning('The idle_timeout parameter is deprecated. Please use connection_recycle_time instead.')
  }

  $database_options = {
    "${config_group}/sqlite_synchronous"      => { value => $sqlite_synchronous },
    "${config_group}/backend"                 => { value => $backend },
    "${config_group}/connection"              => { value => $connection, secret => true },
    "${config_group}/slave_connection"        => { value => $slave_connection, secret => true },
    "${config_group}/mysql_sql_mode"          => { value => $mysql_sql_mode },
    "${config_group}/connection_recycle_time" => { value => $connection_recycle_time },
    "${config_group}/min_pool_size"           => { value => $min_pool_size },
    "${config_group}/max_pool_size"           => { value => $max_pool_size },
    "${config_group}/max_retries"             => { value => $max_retries },
    "${config_group}/retry_interval"          => { value => $retry_interval },
    "${config_group}/max_overflow"            => { value => $max_overflow },
    "${config_group}/connection_debug"        => { value => $connection_debug },
    "${config_group}/connection_trace"        => { value => $connection_trace },
    "${config_group}/pool_timeout"            => { value => $pool_timeout },
    "${config_group}/use_db_reconnect"        => { value => $use_db_reconnect },
    "${config_group}/db_retry_interval"       => { value => $db_retry_interval },
    "${config_group}/db_inc_retry_interval"   => { value => $db_inc_retry_interval },
    "${config_group}/db_max_retry_interval"   => { value => $db_max_retry_interval },
    "${config_group}/db_max_retries"          => { value => $db_max_retries },
    "${config_group}/use_tpool"               => { value => $use_tpool },
  }

  create_resources($name, $database_options)

}
