# == Define: oslo::messaging::amqp
#
# DEPRECATED !!
# Configure oslo_messaging_amqp options
#
# This resource configures Oslo messaging resources for an OpenStack service.
# It will manage the [oslo_messaging_amqp] section in the given config resource.
#
# === Parameters:
#
# [*addressing_mode*]
#   (Optional) Indicates the addressing mode used by the driver
#   Defaults to $facts['os_service_default'].
#
# [*server_request_prefix*]
#   (Optional) Address prefix used when sending to a specific server
#   Defaults to $facts['os_service_default'].
#
# [*broadcast_prefix*]
#   (Optional) Address prefix used when broadcasting to all servers
#   Defaults to $facts['os_service_default'].
#
# [*group_request_prefix*]
#   (Optional) Address prefix when sending to any server in group
#   Defaults to $facts['os_service_default'].
#
# [*rpc_address_prefix*]
#   (Optional) Address prefix for all generated RPC addresses
#   Defaults to $facts['os_service_default'].
#
# [*notify_address_prefix*]
#   (Optional) Address prefix for all generated Notification addresses
#   Defaults to $facts['os_service_default'].
#
# [*multicast_address*]
#   (Optional) Appended to address prefix when sending fanout message
#   Defaults to $facts['os_service_default'].
#
# [*unicast_address*]
#   (Optional) Appended to address prefix when sending to a
#   particular RPC/Notification server.
#   Defaults to $facts['os_service_default'].
#
# [*anycast_address*]
#   (Optional) Appended to address prefix when sending to a
#   group of consumers.
#   Defaults to $facts['os_service_default'].
#
# [*default_notification_exchange*]
#   (Optional) Exchange name used in notification addresses
#   Defaults to $facts['os_service_default'].
#
# [*default_rpc_exchange*]
#   (Optional) Exchange name used in RPC addresses
#   Defaults to $facts['os_service_default'].
#
# [*pre_settled*]
#   (Optional) Send messages of this type pre-settled
#   Defaults to $facts['os_service_default'].
#
# [*container_name*]
#   (Optional) Name for the AMQP container
#   Defaults to $facts['os_service_default'].
#
# [*idle_timeout*]
#   (Optional) Timeout for inactive connections
#   Defaults to $facts['os_service_default'].
#
# [*trace*]
#   (Optional) Debug: dump AMQP frames to stdout
#   Defaults to $facts['os_service_default'].
#
# [*ssl*]
#   (Optional) Attempt to connect via SSL.
#   Defaults to $facts['os_service_default'].
#
# [*ssl_ca_file*]
#   (Optional) CA certificate PEM file to verify server certificate
#   Defaults to $facts['os_service_default'].
#
# [*ssl_cert_file*]
#   (Optional) Identifying certificate PEM file to present to clients
#   Defaults to $facts['os_service_default'].
#
# [*ssl_key_file*]
#   (Optional) Private key PEM file used to sign cert_file certificate
#   Defaults to $facts['os_service_default'].
#
# [*ssl_key_password*]
#   (Optional) Password for decrypting ssl_key_file (if encrypted)
#   Defaults to $facts['os_service_default'].
#
# [*sasl_mechanisms*]
#   (Optional) Space separated list of acceptable SASL mechanisms
#   Defaults to $facts['os_service_default'].
#
# [*sasl_config_dir*]
#   (Optional) Path to directory that contains the SASL configuration
#   Defaults to $facts['os_service_default'].
#
# [*sasl_config_name*]
#   (Optional) Name of configuration file (without .conf suffix)
#   Defaults to $facts['os_service_default'].
#
# [*sasl_default_realm*]
#   (Optional) SASL realm to use if not realm present in username
#   Defaults to $facts['os_service_default'].
#
# [*username*]
#   (Optional) User name for message broker authentication
#   Defaults to $facts['os_service_default'].
#
# [*password*]
#   (Optional) Password for message broker authentication
#   Defaults to $facts['os_service_default'].
#
# [*default_send_timeout*]
#   (Optional) The deadline for an rpc cast or call message delivery
#   Defaults to $facts['os_service_default'].
#
# [*default_notify_timeout*]
#   (Optional) The deadline for a sent notification message delivery
#   Defaults to $facts['os_service_default'].
#
define oslo::messaging::amqp(
  $addressing_mode               = $facts['os_service_default'],
  $server_request_prefix         = $facts['os_service_default'],
  $broadcast_prefix              = $facts['os_service_default'],
  $group_request_prefix          = $facts['os_service_default'],
  $rpc_address_prefix            = $facts['os_service_default'],
  $notify_address_prefix         = $facts['os_service_default'],
  $multicast_address             = $facts['os_service_default'],
  $unicast_address               = $facts['os_service_default'],
  $anycast_address               = $facts['os_service_default'],
  $default_notification_exchange = $facts['os_service_default'],
  $default_rpc_exchange          = $facts['os_service_default'],
  $pre_settled                   = $facts['os_service_default'],
  $container_name                = $facts['os_service_default'],
  $idle_timeout                  = $facts['os_service_default'],
  $trace                         = $facts['os_service_default'],
  $ssl                           = $facts['os_service_default'],
  $ssl_ca_file                   = $facts['os_service_default'],
  $ssl_cert_file                 = $facts['os_service_default'],
  $ssl_key_file                  = $facts['os_service_default'],
  $ssl_key_password              = $facts['os_service_default'],
  $sasl_mechanisms               = $facts['os_service_default'],
  $sasl_config_dir               = $facts['os_service_default'],
  $sasl_config_name              = $facts['os_service_default'],
  $sasl_default_realm            = $facts['os_service_default'],
  $username                      = $facts['os_service_default'],
  $password                      = $facts['os_service_default'],
  $default_send_timeout          = $facts['os_service_default'],
  $default_notify_timeout        = $facts['os_service_default'],
){

  $amqp_options={ 'oslo_messaging_amqp/addressing_mode'               => { value => $addressing_mode },
                  'oslo_messaging_amqp/server_request_prefix'         => { value => $server_request_prefix },
                  'oslo_messaging_amqp/broadcast_prefix'              => { value => $broadcast_prefix },
                  'oslo_messaging_amqp/group_request_prefix'          => { value => $group_request_prefix },
                  'oslo_messaging_amqp/rpc_address_prefix'            => { value => $rpc_address_prefix },
                  'oslo_messaging_amqp/notify_address_prefix'         => { value => $notify_address_prefix },
                  'oslo_messaging_amqp/multicast_address'             => { value => $multicast_address },
                  'oslo_messaging_amqp/unicast_address'               => { value => $unicast_address },
                  'oslo_messaging_amqp/anycast_address'               => { value => $anycast_address },
                  'oslo_messaging_amqp/default_notification_exchange' => { value => $default_notification_exchange },
                  'oslo_messaging_amqp/default_rpc_exchange'          => { value => $default_rpc_exchange },
                  'oslo_messaging_amqp/pre_settled'                   => { value => any2array($pre_settled) },
                  'oslo_messaging_amqp/container_name'                => { value => $container_name },
                  'oslo_messaging_amqp/idle_timeout'                  => { value => $idle_timeout },
                  'oslo_messaging_amqp/trace'                         => { value => $trace },
                  'oslo_messaging_amqp/ssl'                           => { value => $ssl },
                  'oslo_messaging_amqp/ssl_ca_file'                   => { value => $ssl_ca_file },
                  'oslo_messaging_amqp/ssl_cert_file'                 => { value => $ssl_cert_file },
                  'oslo_messaging_amqp/ssl_key_file'                  => { value => $ssl_key_file },
                  'oslo_messaging_amqp/ssl_key_password'              => { value => $ssl_key_password, secret => true },
                  'oslo_messaging_amqp/sasl_mechanisms'               => { value => $sasl_mechanisms },
                  'oslo_messaging_amqp/sasl_config_dir'               => { value => $sasl_config_dir },
                  'oslo_messaging_amqp/sasl_config_name'              => { value => $sasl_config_name },
                  'oslo_messaging_amqp/sasl_default_realm'            => { value => $sasl_default_realm },
                  'oslo_messaging_amqp/username'                      => { value => $username },
                  'oslo_messaging_amqp/password'                      => { value => $password, secret => true },
                  'oslo_messaging_amqp/default_send_timeout'          => { value => $default_send_timeout },
                  'oslo_messaging_amqp/default_notify_timeout'        => { value => $default_notify_timeout },
                }
  create_resources($name, $amqp_options)
}
