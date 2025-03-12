# == Define: oslo::messaging::rabbit
#
# Configure oslo_messaging_rabbit options
#
# This resource configures Oslo messaging resources for an OpenStack service.
# It manages the [oslo_messaging_rabbit] section in the given config resource.
#
# === Parameters:
#
#  [*amqp_durable_queues*]
#   (optional) Define queues as "durable" to rabbitmq. (boolean value)
#   Defaults to $facts['os_service_default']
#
#  [*amqp_auto_delete*]
#   (optional) Define if transient queues should be auto-deleted (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_version*]
#   (Optional) SSL version to use (valid only if SSL enabled). '
#   Valid values are TLSv1 and SSLv23. SSLv2, SSLv3, TLSv1_1,
#   and TLSv1_2 may be available on some distributions. (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_keyfile*]
#   (Optional) SSL key file (valid only if SSL enabled). (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_certfile*]
#   (Optional) SSL cert file (valid only if SSL enabled). (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_ca_certs*]
#   (Optional) SSL certification authority file (valid only if SSL enabled).
#   (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_reconnect_delay*]
#   (Optional) How long to wait before reconnecting in response
#   to an AMQP consumer cancel notification. (floating point value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_missing_consumer_retry_timeout*]
#   (Optional) How long to wait a missing client before abandoning to send it
#   its replies. This value should not be longer than rpc_response_timeout.
#   (integer value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_failover_strategy*]
#   (Optional) Determines how the next RabbitMQ node is chosen in case the one
#   we are currently connected to becomes unavailable. Takes effect only if
#   more than one RabbitMQ node is provided in config. (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_compression*]
#   (optional) Possible values are: gzip, bz2. If not set compression will not
#   be used. This option may not be available in future versions. EXPERIMENTAL.
#   (string value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_qos_prefetch_count*]
#   (Optional) Specifies the number of messages to prefetch
#   Defaults to $facts['os_service_default']
#
# [*rabbit_use_ssl*]
#   (Optional) Connect over SSL for RabbitMQ. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_login_method*]
#   (Optional) The RabbitMQ login method. (string value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_retry_interval*]
#   (Optional) How frequently to retry connecting with RabbitMQ.
#   (integer value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_retry_backoff*]
#   (Optional) How long to backoff for between retries when connecting
#   to RabbitMQ. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_interval_max*]
#   (Optional) Maximum interval of RabbitMQ connection retries. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_ha_queues*]
#   (Optional) Use HA queues in RabbitMQ (x-ha-policy: all). If you change this
#   option, you must wipe the RabbitMQ database. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_transient_queues_ttl*]
#   (Optional) Positive integer representing duration in seconds for
#   queue TTL (x-expires). Queues which are unused for the duration
#   of the TTL are automatically deleted.
#   The parameter affects only reply and fanout queues. (integer value)
#   Min to 1
#   Defaults to $facts['os_service_default']
#
# [*heartbeat_timeout_threshold*]
#   (Optional) Number of seconds after which the Rabbit broker is
#   considered down if heartbeat's keep-alive fails
#   (0 disable the heartbeat). EXPERIMENTAL. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*heartbeat_rate*]
#   (Optional) How often times during the heartbeat_timeout_threshold
#   we check the heartbeat. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_quorum_queue*]
#   (Optional) Use quorum queues in RabbitMQ.
#   Defaults to $facts['os_service_default']
#
# [*rabbit_transient_quorum_queue*]
#   (Optional) Use quorum queues for transients queues in RabbitMQ.
#   Defaults to $facts['os_service_default']
#
# [*rabbit_quorum_delivery_limit*]
#   (Optional) Each time a message is rdelivered to a consumer, a counter is
#   incremented. Once the redelivery count exceeds the delivery limit
#   the message gets dropped or dead-lettered.
#   Defaults to $facts['os_service_default']
#
# [*rabbit_quorum_max_memory_length*]
#   (Optional) Limit the number of messages in the quorum queue.
#   Defaults to $facts['os_service_default']
#
# [*rabbit_quorum_max_memory_bytes*]
#   (Optional) Limit the number of memory bytes used by the quorum queue.
#   Defaults to $facts['os_service_default']
#
# [*enable_cancel_on_failover*]
#   (Optional) Enable x-cancel-on-ha-failover flag so that rabbitmq server will
#   cancel and notify consumers when queue is down.
#   Defaults to $facts['os_service_default']
#
# [*use_queue_manager*]
#   (Optional) Should we use consistent queue names or random ones.
#   Defaults to $facts['os_service_default']
#
# [*hostname*]
#   (Optional) Hostname used by queue manager.
#   Defaults to $facts['os_service_default']
#
# [*processname*]
#   (Optional) Process name used by queue manager.
#   Defaults to $facts['os_service_default']
#
# [*rabbit_stream_fanout*]
#   (Optional) Use stream queues in RabbitMQ (x-queue-type: stream) for
#   fanout queues.
#   Defaults to $facts['os_service_default']
#
# DEPRECATED PARAMETERS
#
# [*heartbeat_in_pthread*]
#   (Optional) EXPERIMENTAL: Run the health check heartbeat thread
#   through a native python thread. By default if this
#   option isn't provided the  health check heartbeat will
#   inherit the execution model from the parent process. By
#   example if the parent process have monkey patched the
#   stdlib by using eventlet/greenlet then the heartbeat
#   will be run through a green thread.
#   Defaults to undef
#
define oslo::messaging::rabbit(
  $amqp_durable_queues                  = $facts['os_service_default'],
  $amqp_auto_delete                     = $facts['os_service_default'],
  $kombu_ssl_version                    = $facts['os_service_default'],
  $kombu_ssl_keyfile                    = $facts['os_service_default'],
  $kombu_ssl_certfile                   = $facts['os_service_default'],
  $kombu_ssl_ca_certs                   = $facts['os_service_default'],
  $kombu_reconnect_delay                = $facts['os_service_default'],
  $kombu_missing_consumer_retry_timeout = $facts['os_service_default'],
  $kombu_failover_strategy              = $facts['os_service_default'],
  $kombu_compression                    = $facts['os_service_default'],
  $rabbit_qos_prefetch_count            = $facts['os_service_default'],
  $rabbit_use_ssl                       = $facts['os_service_default'],
  $rabbit_login_method                  = $facts['os_service_default'],
  $rabbit_retry_interval                = $facts['os_service_default'],
  $rabbit_retry_backoff                 = $facts['os_service_default'],
  $rabbit_interval_max                  = $facts['os_service_default'],
  $rabbit_ha_queues                     = $facts['os_service_default'],
  $rabbit_transient_queues_ttl          = $facts['os_service_default'],
  $heartbeat_timeout_threshold          = $facts['os_service_default'],
  $heartbeat_rate                       = $facts['os_service_default'],
  $rabbit_quorum_queue                  = $facts['os_service_default'],
  $rabbit_transient_quorum_queue        = $facts['os_service_default'],
  $rabbit_quorum_delivery_limit         = $facts['os_service_default'],
  $rabbit_quorum_max_memory_length      = $facts['os_service_default'],
  $rabbit_quorum_max_memory_bytes       = $facts['os_service_default'],
  $enable_cancel_on_failover            = $facts['os_service_default'],
  $use_queue_manager                    = $facts['os_service_default'],
  $hostname                             = $facts['os_service_default'],
  $processname                          = $facts['os_service_default'],
  $rabbit_stream_fanout                 = $facts['os_service_default'],
  # DEPRECATED PARAMETERS
  $heartbeat_in_pthread                 = undef,
){

  if $heartbeat_in_pthread != undef {
    warning('The heartbeat_in_pthread parameter is deprecated.')
  }

  $kombu_ssl_ca_certs_set = (!is_service_default($kombu_ssl_ca_certs) and ($kombu_ssl_ca_certs))
  $kombu_ssl_certfile_set = (!is_service_default($kombu_ssl_certfile) and ($kombu_ssl_certfile))
  $kombu_ssl_keyfile_set  = (!is_service_default($kombu_ssl_keyfile) and ($kombu_ssl_keyfile))
  $kombu_ssl_version_set  = (!is_service_default($kombu_ssl_version) and ($kombu_ssl_version))

  if $rabbit_use_ssl != true {
    if $kombu_ssl_ca_certs_set {
      fail('The kombu_ssl_ca_certs parameter requires rabbit_use_ssl to be set to true')
    }
    if $kombu_ssl_certfile_set {
      fail('The kombu_ssl_certfile parameter requires rabbit_use_ssl to be set to true')
    }
    if $kombu_ssl_keyfile_set {
      fail('The kombu_ssl_keyfile parameter requires rabbit_use_ssl to be set to true')
    }
    if $kombu_ssl_version_set {
      fail('The kombu_ssl_version parameter requires rabbit_use_ssl to be set to true')
    }
  } else {
    if ($kombu_ssl_certfile_set != $kombu_ssl_keyfile_set) {
      fail('The kombu_ssl_certfile parameter and the kombu_ssl_keyfile parameters must be used together')
    }
  }

  if !is_service_default($kombu_compression) and !($kombu_compression in ['gzip','bz2']) {
    fail('Unsupported Kombu compression. Possible values are gzip and bz2')
  }

  $rabbit_options = {
    'oslo_messaging_rabbit/amqp_durable_queues'                  => { value => $amqp_durable_queues },
    'oslo_messaging_rabbit/amqp_auto_delete'                     => { value => $amqp_auto_delete },
    'oslo_messaging_rabbit/heartbeat_rate'                       => { value => $heartbeat_rate },
    'oslo_messaging_rabbit/heartbeat_in_pthread'                 => { value => pick($heartbeat_in_pthread, $facts['os_service_default']) },
    'oslo_messaging_rabbit/heartbeat_timeout_threshold'          => { value => $heartbeat_timeout_threshold },
    'oslo_messaging_rabbit/kombu_compression'                    => { value => $kombu_compression },
    'oslo_messaging_rabbit/kombu_failover_strategy'              => { value => $kombu_failover_strategy },
    'oslo_messaging_rabbit/kombu_missing_consumer_retry_timeout' => { value => $kombu_missing_consumer_retry_timeout },
    'oslo_messaging_rabbit/kombu_reconnect_delay'                => { value => $kombu_reconnect_delay },
    'oslo_messaging_rabbit/rabbit_interval_max'                  => { value => $rabbit_interval_max },
    'oslo_messaging_rabbit/rabbit_login_method'                  => { value => $rabbit_login_method },
    'oslo_messaging_rabbit/rabbit_retry_backoff'                 => { value => $rabbit_retry_backoff },
    'oslo_messaging_rabbit/rabbit_retry_interval'                => { value => $rabbit_retry_interval },
    'oslo_messaging_rabbit/rabbit_transient_queues_ttl'          => { value => $rabbit_transient_queues_ttl },
    'oslo_messaging_rabbit/ssl'                                  => { value => $rabbit_use_ssl },
    'oslo_messaging_rabbit/rabbit_qos_prefetch_count'            => { value => $rabbit_qos_prefetch_count },
    'oslo_messaging_rabbit/rabbit_ha_queues'                     => { value => $rabbit_ha_queues },
    'oslo_messaging_rabbit/rabbit_quorum_queue'                  => { value => $rabbit_quorum_queue },
    'oslo_messaging_rabbit/rabbit_transient_quorum_queue'        => { value => $rabbit_transient_quorum_queue },
    'oslo_messaging_rabbit/rabbit_quorum_delivery_limit'         => { value => $rabbit_quorum_delivery_limit },
    'oslo_messaging_rabbit/rabbit_quorum_max_memory_length'      => { value => $rabbit_quorum_max_memory_length },
    'oslo_messaging_rabbit/rabbit_quorum_max_memory_bytes'       => { value => $rabbit_quorum_max_memory_bytes },
    'oslo_messaging_rabbit/enable_cancel_on_failover'            => { value => $enable_cancel_on_failover },
    'oslo_messaging_rabbit/use_queue_manager'                    => { value => $use_queue_manager },
    'oslo_messaging_rabbit/hostname'                             => { value => $hostname },
    'oslo_messaging_rabbit/processname'                          => { value => $processname },
    'oslo_messaging_rabbit/rabbit_stream_fanout'                 => { value => $rabbit_stream_fanout },
    'oslo_messaging_rabbit/ssl_ca_file'                          => { value => $kombu_ssl_ca_certs },
    'oslo_messaging_rabbit/ssl_cert_file'                        => { value => $kombu_ssl_certfile },
    'oslo_messaging_rabbit/ssl_key_file'                         => { value => $kombu_ssl_keyfile },
    'oslo_messaging_rabbit/ssl_version'                          => { value => $kombu_ssl_version },
  }

  create_resources($name, $rabbit_options)
}
