# == Define: oslo::messaging::amqp
#
# Configure oslo_messaging_amqp options
#
# This resource configures Oslo messaging resources for an OpenStack service.
# It will manage the [oslo_messaging_amqp] section in the given config resource.
#
# === Parameters:
#
# [*server_request_prefix*]
#   (Optional) Address prefix used when sending to a specific server
#   Defaults to $::os_service_default.
#
# [*broadcast_prefix*]
#   (Optional) address prefix used when broadcasting to all servers
#   Defaults to $::os_service_default.
#
# [*group_request_prefix*]
#   (Optional) address prefix when sending to any server in group
#   Defaults to $::os_service_default.
#
# [*container_name*]
#   (Optional) Name for the AMQP container
#   Defaults to $::os_service_default.
#
# [*idle_timeout*]
#   (Optional) Timeout for inactive connections
#   Defaults to $::os_service_default.
#
# [*trace*]
#   (Optional) Debug: dump AMQP frames to stdout
#   Defaults to $::os_service_default.
#
# [*ssl_ca_file*]
#   (Optional) CA certificate PEM file to verify server certificate
#   Defaults to $::os_service_default.
#
# [*ssl_cert_file*]
#   (Optional) Identifying certificate PEM file to present to clients
#   Defaults to $::os_service_default.
#
# [*ssl_key_file*]
#   (Optional) Private key PEM file used to sign cert_file certificate
#   Defaults to $::os_service_default.
#
# [*ssl_key_password*]
#   (Optional) Password for decrypting ssl_key_file (if encrypted)
#   Defaults to $::os_service_default.
#
# [*allow_insecure_clients*]
#   (Optional) Accept clients using either SSL or plain TCP
#   Defaults to $::os_service_default.
#
# [*sasl_mechanisms*]
#   (Optional) Space separated list of acceptable SASL mechanisms
#   Defaults to $::os_service_default.
#
# [*sasl_config_dir*]
#   (Optional) Path to directory that contains the SASL configuration
#   Defaults to $::os_service_default.
#
# [*sasl_config_name*]
#   (Optional) Name of configuration file (without .conf suffix)
#   Defaults to $::os_service_default.
#
# [*username*]
#   (Optional) User name for message broker authentication
#   Defaults to $::os_service_default.
#
# [*password*]
#   (Optional) Password for message broker authentication
#   Defaults to $::os_service_default.
#
define oslo::messaging::amqp(
  $server_request_prefix   = $::os_service_default,
  $broadcast_prefix        = $::os_service_default,
  $group_request_prefix    = $::os_service_default,
  $container_name          = $::os_service_default,
  $idle_timeout            = $::os_service_default,
  $trace                   = $::os_service_default,
  $ssl_ca_file             = $::os_service_default,
  $ssl_cert_file           = $::os_service_default,
  $ssl_key_file            = $::os_service_default,
  $ssl_key_password        = $::os_service_default,
  $allow_insecure_clients  = $::os_service_default,
  $sasl_mechanisms         = $::os_service_default,
  $sasl_config_dir         = $::os_service_default,
  $sasl_config_name        = $::os_service_default,
  $username                = $::os_service_default,
  $password                = $::os_service_default,
){
  $amqp_options={ 'oslo_messaging_amqp/server_request_prefix' => { value => $server_request_prefix },
                  'oslo_messaging_amqp/broadcast_prefix' => { value => $broadcast_prefix },
                  'oslo_messaging_amqp/group_request_prefix' => { value => $group_request_prefix },
                  'oslo_messaging_amqp/container_name' => { value => $container_name },
                  'oslo_messaging_amqp/idle_timeout' => { value => $idle_timeout },
                  'oslo_messaging_amqp/trace' => { value => $trace },
                  'oslo_messaging_amqp/ssl_ca_file' => { value => $ssl_ca_file },
                  'oslo_messaging_amqp/ssl_cert_file' => { value => $ssl_cert_file },
                  'oslo_messaging_amqp/ssl_key_file' => { value => $ssl_key_file },
                  'oslo_messaging_amqp/ssl_key_password' => { value => $ssl_key_password },
                  'oslo_messaging_amqp/allow_insecure_clients' => { value => $allow_insecure_clients },
                  'oslo_messaging_amqp/sasl_mechanisms' => { value => $sasl_mechanisms },
                  'oslo_messaging_amqp/sasl_config_dir' => { value => $sasl_config_dir },
                  'oslo_messaging_amqp/sasl_config_name' => { value => $sasl_config_name },
                  'oslo_messaging_amqp/username' => { value => $username },
                  'oslo_messaging_amqp/password' => { value => $password },
                  'DEFAULT/rpc_backend' => { value => 'amqp' },
                }
  create_resources($name, $amqp_options)
}
