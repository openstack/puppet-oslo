# == Define: oslo::messaging_rabbit
#
# Configure oslo_messaging_rabbit options
#
# This resource configures Oslo messaging resources for an OpenStack service.
# It will manage the [oslo_messaging_rabbit] section in the given config resource.
#
# === Parameters:
#
# [*kombu_ssl_version*]
#   (Optional) SSL version to use (valid only if SSL enabled). '
#   Valid values are TLSv1 and SSLv23.
#   SSLv2, SSLv3, TLSv1_1, and TLSv1_2 may be available on some distributions.
#   Defaults to undef.
#
# [*kombu_ssl_keyfile*]
#   (Optional) SSL key file (valid only if SSL enabled)
#   Defaults to undef.
#
# [*kombu_ssl_certfile*]
#   (Optional) SSL cert file (valid only if SSL enabled)
#   Defaults to undef.
#
# [*kombu_ssl_ca_certs*]
#   (Optional) SSL certification authority file (valid only if SSL enabled)
#   Defaults to undef.
#
# [*kombu_reconnect_delay*]
#   (Optional) How long to wait before reconnecting in response to an AMQP consumer cancel notification.
#   Defaults to '1'.
#
# [*kombu_missing_consumer_retry_timeout*]
#   (Optional) How long to wait a missing client beforce abandoning to
#   send it its replies. This value should not be longer than rpc_response_timeout.
#   Defaults to '60'.
#
# [*kombu_failover_strategy*]
#   (Optional) Determines how the next RabbitMQ node is chosen in case
#   the one we are currently connected to becomes unavailable.
#   Takes effect only if more than one RabbitMQ node is provided in config.
#   Defaults to 'round-robin'.
#
# [*rabbit_host*]
#   (Optional) The RabbitMQ broker address where a single node is used.
#   Defaults to 'localhost'.
#
# [*rabbit_port*]
#   (Optional) The RabbitMQ broker port where a single node is used.
#   Defaults to '5672'.
#
# [*rabbit_hosts*]
#   (Optional) RabbitMQ HA cluster host:port pairs.
#   Defaults to ['localhost:5672'].
#
# [*rabbit_use_ssl*]
#   (Optional) Connect over SSL for RabbitMQ.
#   Defaults to false.
#
# [*rabbit_userid*]
#   (Optional) The RabbitMQ userid.
#   Defaults to 'guest'.
#
# [*rabbit_password*]
#   (Optional) The RabbitMQ password.
#   Defaults to undef.
#
# [*rabbit_login_method*]
#   (Optional) The RabbitMQ login method.
#   Defaults to 'AMQPLAIN'.
#
# [*rabbit_virtual_host*]
#   (Optional) The RabbitMQ virtual host.
#   Defaults to '/'.
#
# [*rabbit_retry_interval*]
#   (Optional) How frequently to retry connecting with RabbitMQ.
#   Defaults to 1.
#
# [*rabbit_retry_backoff*]
#   (Optional) How long to backoff for between retries when connecting to RabbitMQ.
#   Defaults to 2.
#
# [*rabbit_interval_max*]
#   (Optional) Maximum interval of RabbitMQ connection retries.
#   Defaults to 30.
#
# [*rabbit_max_retries*]
#   (Optional) Maximum number of RabbitMQ connection retries.
#   Defaults to 0.
#
# [*rabbit_ha_queues*]
#   (Optional) Use HA queues in RabbitMQ (x-ha-policy: all).
#   If you change this option, you must wipe the RabbitMQ database.
#   Defaults to false.
#
# [*rabbit_transient_queues_ttl*]
#   (Optional) Positive integer representing duration in seconds for
#   queue TTL (x-expires). Queues which are unused for the duration
#   of the TTL are automatically deleted.
#   The parameter affects only reply and fanout queues.
#   Min to 1
#   Defaults to 600.
#
# [*heartbeat_timeout_threshold*]
#   (Optional) Number of seconds after which the Rabbit broker is
#   considered down if heartbeat's keep-alive fails
#   (0 disable the heartbeat). EXPERIMENTAL")
#   Defaults to 60.
#
# [*heartbeat_rate*]
#   (Optional) How often times during the heartbeat_timeout_threshold
#   we check the heartbeat.
#   Defaults to 2.
#
# DEPRECATED:
# [*fake_rabbit*]

define oslo::messaging_rabbit(
  $kombu_ssl_version                    = undef,
  $kombu_ssl_keyfile                    = undef,
  $kombu_ssl_certfile                   = undef,
  $kombu_ssl_ca_certs                   = undef,
  $kombu_reconnect_delay                = '1',
  $kombu_missing_consumer_retry_timeout = '60',
  $kombu_failover_strategy              = 'round-robin',
  $rabbit_host                          = 'localhost',
  $rabbit_port                          = '5672',
  $rabbit_hosts                         = 'localhost:5672',
  $rabbit_use_ssl                       = false,
  $rabbit_userid                        = 'guest',
  $rabbit_password                      = undef,
  $rabbit_login_method                  = 'AMQPLAIN',
  $rabbit_virtual_host                  = '/',
  $rabbit_retry_interval                = '1',
  $rabbit_retry_backoff                 = '2',
  $rabbit_interval_max                  = '30',
  $rabbit_max_retries                   = '0',
  $rabbit_ha_queues                     = false,
  $rabbit_transient_queues_ttl          = '600',
  $heartbeat_timeout_threshold          = '60',
  $heartbeat_rate                       = '2',
  $fake_rabbit                          = undef,
){
  create_resources($name, {'oslo_messaging_rabbit/kombu_ssl_version' => { value => $kombu_ssl_version }})
  create_resources($name, {'oslo_messaging_rabbit/kombu_ssl_keyfile' => { value => $kombu_ssl_keyfile }})
  create_resources($name, {'oslo_messaging_rabbit/kombu_ssl_certfile' => { value => $kombu_ssl_certfile }})
  create_resources($name, {'oslo_messaging_rabbit/kombu_ssl_ca_certs' => { value => $kombu_ssl_ca_certs }})
  create_resources($name, {'oslo_messaging_rabbit/kombu_reconnect_delay' => { value => $kombu_reconnect_delay }})
  create_resources($name, {'oslo_messaging_rabbit/kombu_missing_consumer_retry_timeout' => { value => $kombu_missing_consumer_retry_timeout }})
  create_resources($name, {'oslo_messaging_rabbit/kombu_failover_strategy' => { value => $kombu_failover_strategy }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_host' => { value => $rabbit_host }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_port' => { value => $rabbit_port }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_hosts' => { value => $rabbit_hosts }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_use_ssl' => { value => $rabbit_use_ssl }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_userid' => { value => $rabbit_userid }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_password' => { value => $rabbit_password }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_login_method' => { value => $rabbit_login_method }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_virtual_host' => { value => $rabbit_virtual_host }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_retry_interval' => { value => $rabbit_retry_interval }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_retry_backoff' => { value => $rabbit_retry_backoff }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_interval_max' => { value => $rabbit_interval_max }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_max_retries' => { value => $rabbit_max_retries }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_ha_queues' => { value => $rabbit_ha_queues }})
  create_resources($name, {'oslo_messaging_rabbit/rabbit_transient_queues_ttl' => { value => $rabbit_transient_queues_ttl }})
  create_resources($name, {'oslo_messaging_rabbit/heartbeat_timeout_threshold' => { value => $heartbeat_timeout_threshold }})
  create_resources($name, {'oslo_messaging_rabbit/heartbeat_rate' => { value => $heartbeat_rate }})
  if $fake_rabbit {
    warning('fake_rabbit is depracted, please use use rpc_backend=kombu+memory or rpc_backend=fake')
    create_resources($name, {'oslo_messaging_rabbit/fake_rabbit' => { value => $fake_rabbit }})
  }
}
