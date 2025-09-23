# == Define: oslo::cache
#
# Configure oslo.cache options
#
# This resource configures Oslo cache resources for an OpenStack service.
# It will manage the [cache] section in the given config resource.
# It supports all of the oslo.cache parameters specified at
# https://github.com/openstack/oslo.cache/blob/master/oslo_cache/_opts.py
#
# For example, when configuring glance cache, instead of doing this:
#
#     glance_api_config {
#       'cache/memcached_servers':   value => $memcached_servers;
#       'cache/memcache_dead_retry': value => $memcache_dead_retry;
#       ...
#     }
#
# manifests should do this instead::
#
#    oslo::cache { 'glance_api_config':
#      memcached_servers   => $memcached_servers,
#      memcache_dead_retry => $memcache_dead_retry,
#      ...
#    }
#
# or add following code in glance::api:
#
#    create_resources(oslo::cache, $cache_config)
#
# Then in hiera should add this:
#
#   glance::api::cache_config:
#     'glance_api_config':
#       memcached_servers: '127.0.0.1'
#       memcache_dead_retry: '100'
#
# === Parameters:
#
# [*config_prefix*]
#   (Optional) Prefix for building the configuration dictionary for
#   the cache region. This should not need to be changed unless there
#   is another dogpile.cache region with the same configuration name.
#   (string value)
#   Defaults to $facts['os_service_default']
#
# [*expiration_time*]
#   (Optional) Default TTL, in seconds, for any cached item in the
#   dogpile.cache region. This applies to any cached method that
#   doesn't have an explicit cache expiration time defined for it.
#   (integer value)
#   Defaults to $facts['os_service_default']
#
# [*backend_expiration_time*]
#   (Optional) Expiration time in cache backend to purge expired records
#   automatically.
#   Defaults to $facts['os_service_default']
#
# [*backend*]
#   (Optional) Dogpile.cache backend module. It is recommended that
#   Memcache with pooling (oslo_cache.memcache_pool) or Redis
#   (dogpile.cache.redis) be used in production deployments. (string value)
#   Defaults to $facts['os_service_default']
#
# [*backend_argument*]
#   (Optional) Arguments supplied to the backend module. Specify this option
#   once per argument to be passed to the dogpile.cache backend.
#   Example format: "<argname>:<value>". (list value)
#   Defaults to $facts['os_service_default']
#
# [*proxies*]
#   (Optional) Proxy classes to import that will affect the way the
#   dogpile.cache backend functions. See the dogpile.cache documentation on
#   changing-backend-behavior. (list value)
#   Defaults to $facts['os_service_default']
#
# [*enabled*]
#   (Optional) Global toggle for caching. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*debug_cache_backend*]
#   (Optional) Extra debugging from the cache backend (cache keys,
#   get/set/delete/etc calls). This is only really useful if you need
#   to see the specific cache-backend get/set/delete calls with the keys/values.
#   Typically this should be left set to false. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*memcache_servers*]
#   (Optional) Memcache servers in the format of "host:port".
#   (dogpile.cache.memcache and oslo_cache.memcache_pool backends only).
#   (list value)
#   Defaults to $facts['os_service_default']
#
# [*memcache_dead_retry*]
#   (Optional) Number of seconds memcached server is considered dead before
#   it is tried again. (dogpile.cache.memcache and oslo_cache.memcache_pool
#   backends only). (integer value)
#   Defaults to $facts['os_service_default']
#
# [*memcache_socket_timeout*]
#   (Optional) Timeout in seconds for every call to a server.
#   (dogpile.cache.memcache and oslo_cache.memcache_pool backends only).
#   (floating point value)
#   Defaults to $facts['os_service_default']
#
# [*enable_socket_keepalive*]
#   (Optional) Global toggle for the socket keepalive of dogpile's
#   pymemcache backend
#   Defaults to $facts['os_service_default']
#
# [*socket_keepalive_idle*]
#   (Optional) The time (in seconds) the connection needs to remain idle
#   before TCP starts sending keepalive probes. Should be a positive integer
#   most greater than zero.
#   Defaults to $facts['os_service_default']
#
# [*socket_keepalive_interval*]
#   (Optional) The time (in seconds) between individual keepalive probes.
#   Should be a positive integer most greater than zero.
#   Defaults to $facts['os_service_default']
#
# [*socket_keepalive_count*]
#   (Optional) The maximum number of keepalive probes TCP should send before
#   dropping the connection. Should be a positive integer most greater than
#   zero.
#   Defaults to $facts['os_service_default']
#
# [*memcache_pool_maxsize*]
#   Max total number of open connections to every memcached server.
#   (oslo_cache.memcache_pool backend only). (integer value)
#   Defaults to $facts['os_service_default']
#
# [*memcache_pool_unused_timeout*]
#   (Optional) Number of seconds a connection to memcached is held unused
#   in the pool before it is closed. (oslo_cache.memcache_pool backend only)
#   (integer value)
#   Defaults to $facts['os_service_default']
#
# [*memcache_pool_connection_get_timeout*]
#   (Optional) Number of seconds that an operation will wait to get a memcache
#   client connection. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*memcache_pool_flush_on_reconnect*]
#   (Optional) Global toggle if memcache will be flushed on reconnect.
#   (oslo_cache.memcache_pool backend only)
#   Defaults to $facts['os_service_default']
#
# [*memcache_sasl_enabled*]
#   (Optional) Whether SASL is enabled in memcached
#   Defaults to $facts['os_service_default']
#
# [*memcache_username*]
#   (Optional) The user name for the memcached with SASL enabled
#   Defaults to $facts['os_service_default']
#
# [*memcache_password*]
#   (Optional) The password for the memcached with SASL enabled
#   Defaults to $facts['os_service_default']
#
# [*redis_server*]
#   (Optional) Redis server in the format of "host:port".
#   Defaults to $facts['os_service_default']
#
# [*redis_username*]
#   (Optional) The user name for redis
#   Defaults to $facts['os_service_default']
#
# [*redis_password*]
#   (Optional) The password for redis
#   Defaults to $facts['os_service_default']
#
# [*redis_sentinels*]
#   (Optional) Redis sentinel servers in the format of host:port
#   Defaults to $facts['os_service_default']
#
# [*redis_socket_timeout*]
#   (Optional) Timeout in seconds for every call to a server
#   Defaults to $facts['os_service_default']
#
# [*redis_sentinel_service_name*]
#   (Optional) Service name of the redis sentinel cluster.
#   Defaults to $facts['os_service_default']
#
# [*tls_enabled*]
#   (Optional) Global toggle for TLS usage when communicating with
#   the caching servers.
#   Default to $facts['os_service_default']
#
# [*tls_cafile*]
#   (Optional) Path to a file of concatenated CA certificates in PEM
#   format necessary to establish the caching server's authenticity.
#   If tls_enabled is False, this option is ignored.
#   Default to $facts['os_service_default']
#
# [*tls_certfile*]
#   (Optional) Path to a single file in PEM format containing the
#   client's certificate as well as any number of CA certificates
#   needed to establish the certificate's authenticity. This file
#   is only required when client side authentication is necessary.
#   If tls_enabled is False, this option is ignored.
#   Default to $facts['os_service_default']
#
# [*tls_keyfile*]
#   (Optional) Path to a single file containing the client's private
#   key in. Otherwise the private key will be taken from the file
#   specified in tls_certfile. If tls_enabled is False, this option
#   is ignored.
#   Default to $facts['os_service_default']
#
# [*tls_allowed_ciphers*]
#   (Optional) Set the available ciphers for sockets created with
#   the TLS context. It should be a string in the OpenSSL cipher
#   list format. If not specified, all OpenSSL enabled ciphers will
#   be available.
#   Default to $facts['os_service_default']
#
# [*enable_retry_client*]
#   (Optional) Enable retry client mechanisms to handle failure.
#   Those mechanisms can be used to wrap all kind of pymemcache
#   clients. The wrapper allows you to define how many attempts
#   to make and how long to wait between attempts.
#   Default to $facts['os_service_default']
#
# [*retry_attempts*]
#   (Optional) Number of times to attempt an action before failing.
#   Default to $facts['os_service_default']
#
# [*retry_delay*]
#   (Optional) Number of seconds to sleep between each attempt.
#   Default to $facts['os_service_default']
#
# [*hashclient_retry_attempts*]
#   (Optional) Amount of times a client should be tried
#   before it is marked dead and removed from the pool in
#   the HashClient's internal mechanisms.
#   Default to $facts['os_service_default']
#
# [*hashclient_retry_delay*]
#   (Optional) Time in seconds that should pass between
#   retry attempts in the HashClient's internal mechanisms.
#   Default to $facts['os_service_default']
#
# [*dead_timeout*]
#   (Optional) Time in seconds before attempting to add a node
#   back in the pool in the HashClient's internal mechanisms.
#   Default to $facts['os_service_default']
#
# [*manage_backend_package*]
#   (Optional) Whether to install the backend package.
#   Defaults to true.
#
# [*package_ensure*]
#   (Optional) ensure state for package.
#   Defaults to 'present'
#
define oslo::cache (
  $config_prefix                          = $facts['os_service_default'],
  $expiration_time                        = $facts['os_service_default'],
  $backend_expiration_time                = $facts['os_service_default'],
  $backend                                = $facts['os_service_default'],
  $backend_argument                       = $facts['os_service_default'],
  $proxies                                = $facts['os_service_default'],
  $enabled                                = $facts['os_service_default'],
  $debug_cache_backend                    = $facts['os_service_default'],
  $memcache_servers                       = $facts['os_service_default'],
  $memcache_dead_retry                    = $facts['os_service_default'],
  $memcache_socket_timeout                = $facts['os_service_default'],
  $enable_socket_keepalive                = $facts['os_service_default'],
  $socket_keepalive_idle                  = $facts['os_service_default'],
  $socket_keepalive_interval              = $facts['os_service_default'],
  $socket_keepalive_count                 = $facts['os_service_default'],
  $memcache_pool_maxsize                  = $facts['os_service_default'],
  $memcache_pool_unused_timeout           = $facts['os_service_default'],
  $memcache_pool_connection_get_timeout   = $facts['os_service_default'],
  $memcache_pool_flush_on_reconnect       = $facts['os_service_default'],
  $memcache_sasl_enabled                  = $facts['os_service_default'],
  $memcache_username                      = $facts['os_service_default'],
  $memcache_password                      = $facts['os_service_default'],
  $redis_server                           = $facts['os_service_default'],
  $redis_username                         = $facts['os_service_default'],
  $redis_password                         = $facts['os_service_default'],
  $redis_sentinels                        = $facts['os_service_default'],
  $redis_socket_timeout                   = $facts['os_service_default'],
  $redis_sentinel_service_name            = $facts['os_service_default'],
  $tls_enabled                            = $facts['os_service_default'],
  $tls_cafile                             = $facts['os_service_default'],
  $tls_certfile                           = $facts['os_service_default'],
  $tls_keyfile                            = $facts['os_service_default'],
  $tls_allowed_ciphers                    = $facts['os_service_default'],
  $enable_retry_client                    = $facts['os_service_default'],
  $retry_attempts                         = $facts['os_service_default'],
  $retry_delay                            = $facts['os_service_default'],
  $hashclient_retry_attempts              = $facts['os_service_default'],
  $hashclient_retry_delay                 = $facts['os_service_default'],
  $dead_timeout                           = $facts['os_service_default'],
  Boolean $manage_backend_package         = true,
  Stdlib::Ensure::Package $package_ensure = present,
) {
  include oslo::params

  if is_service_default($memcache_servers) {
    $memcache_servers_real = $memcache_servers
  } else {
    if $backend =~ /\.memcache/ {
      $memcache_servers_array = $memcache_servers ? {
        String  => split($memcache_servers, ','),
        default => $memcache_servers
      }
      $memcache_servers_real = join(any2array(inet6_prefix($memcache_servers_array)), ',')
    } else {
      $memcache_servers_real = join(any2array($memcache_servers), ',')
    }
  }

  if $manage_backend_package {
    case $backend {
      'dogpile.cache.pylibmc': {
        stdlib::ensure_packages('python-pylibmc', {
          ensure => $package_ensure,
          name   => $oslo::params::pylibmc_package_name,
          tag    => 'openstack',
        })
      }
      'dogpile.cache.bmemcached': {
        stdlib::ensure_packages('python-binary-memcached', {
          name   => $oslo::params::python_bmemcached_package_name,
          ensure => $package_ensure,
          tag    => ['openstack'],
        })
      }
      'dogpile.cache.memcached', 'oslo_cache.memcache_pool': {
        stdlib::ensure_packages('python-memcache', {
          ensure => $package_ensure,
          name   => $oslo::params::python_memcache_package_name,
          tag    => ['openstack'],
        })
      }
      'dogpile.cache.pymemcache': {
        stdlib::ensure_packages('python-pymemcache', {
          ensure => $package_ensure,
          name   => $oslo::params::python_pymemcache_package_name,
          tag    => ['openstack'],
        })
      }
      'dogpile.cache.redis', 'dogpile.cache.redis_sentinel': {
        stdlib::ensure_packages('python-redis', {
          name   => $oslo::params::python_redis_package_name,
          ensure => $package_ensure,
          tag    => ['openstack'],
        })
      }
      'oslo_cache.etcd3gw': {
        stdlib::ensure_packages('python-etcd3gw', {
          name   => $oslo::params::python_etcd3gw_package_name,
          ensure => $package_ensure,
          tag    => 'openstack',
        })
      }
      default: {
        # nothing to install
      }
    }
  }

  $cache_options = {
    'cache/config_prefix'                        => { value => $config_prefix },
    'cache/expiration_time'                      => { value => $expiration_time },
    'cache/backend_expiration_time'              => { value => $backend_expiration_time },
    'cache/backend'                              => { value => $backend },
    'cache/backend_argument'                     => { value => $backend_argument },
    'cache/proxies'                              => { value => join(any2array($proxies), ',') },
    'cache/enabled'                              => { value => $enabled },
    'cache/debug_cache_backend'                  => { value => $debug_cache_backend },
    'cache/memcache_servers'                     => { value => $memcache_servers_real },
    'cache/memcache_dead_retry'                  => { value => $memcache_dead_retry },
    'cache/memcache_socket_timeout'              => { value => $memcache_socket_timeout },
    'cache/enable_socket_keepalive'              => { value => $enable_socket_keepalive },
    'cache/socket_keepalive_idle'                => { value => $socket_keepalive_idle },
    'cache/socket_keepalive_interval'            => { value => $socket_keepalive_interval },
    'cache/socket_keepalive_count'               => { value => $socket_keepalive_count },
    'cache/memcache_pool_maxsize'                => { value => $memcache_pool_maxsize },
    'cache/memcache_pool_unused_timeout'         => { value => $memcache_pool_unused_timeout },
    'cache/memcache_pool_connection_get_timeout' => { value => $memcache_pool_connection_get_timeout },
    'cache/memcache_pool_flush_on_reconnect'     => { value => $memcache_pool_flush_on_reconnect },
    'cache/memcache_sasl_enabled'                => { value => $memcache_sasl_enabled },
    'cache/memcache_username'                    => { value => $memcache_username },
    'cache/memcache_password'                    => { value => $memcache_password, secret => true },
    'cache/redis_server'                         => { value => $redis_server },
    'cache/redis_username'                       => { value => $redis_username },
    'cache/redis_password'                       => { value => $redis_password, secret => true },
    'cache/redis_sentinels'                      => { value => join(any2array($redis_sentinels), ',') },
    'cache/redis_socket_timeout'                 => { value => $redis_socket_timeout },
    'cache/redis_sentinel_service_name'          => { value => $redis_sentinel_service_name },
    'cache/tls_enabled'                          => { value => $tls_enabled },
    'cache/tls_cafile'                           => { value => $tls_cafile },
    'cache/tls_certfile'                         => { value => $tls_certfile },
    'cache/tls_keyfile'                          => { value => $tls_keyfile },
    'cache/tls_allowed_ciphers'                  => { value => join(any2array($tls_allowed_ciphers), ':') },
    'cache/enable_retry_client'                  => { value => $enable_retry_client },
    'cache/retry_attempts'                       => { value => $retry_attempts },
    'cache/retry_delay'                          => { value => $retry_delay },
    'cache/hashclient_retry_attempts'            => { value => $hashclient_retry_attempts },
    'cache/hashclient_retry_delay'               => { value => $hashclient_retry_delay },
    'cache/dead_timeout'                         => { value => $dead_timeout },
  }
  create_resources($name, $cache_options)
}
