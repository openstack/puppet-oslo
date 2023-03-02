# == Define: oslo::service
#
# Configure oslo_service options
#
# This resource configures common parameters of oslo.service library
#
# === Parameters:
#
# [*backdoor_port*]
#   (optional) Enable eventlet backdoor. Acceptable values are 0, <port>, and
#   <start>:<end>, where 0 results in listening on a random tcp port number.
#   Defaults to $facts['os_service_default'].
#
# [*backdoor_socket*]
#   (optional) Enable eventlet backdoor, using the provided path as a unix
#   socket that can receive connections. (string value)
#   Defaults to $facts['os_service_default'].
#
# [*graceful_shutdown_timeout*]
#   (optional) Specify a timeout after which a gracefully shutdown server will
#   exit. '0' value means endless wait. (integer value)
#   Defaults to $facts['os_service_default'].
#
# [*log_options*]
#   (optional) Enables or disables logging values of all registered options
#   when starting a service (at DEBUG level). (boolean value)
#   Defaults to $facts['os_service_default'].
#
# [*run_external_periodic_tasks*]
#   (optional) Some periodic tasks can be run in a separate process.
#   (boolean value)
#   Defaults to $facts['os_service_default'].
#
define oslo::service (
  $backdoor_port               = $facts['os_service_default'],
  $backdoor_socket             = $facts['os_service_default'],
  $graceful_shutdown_timeout   = $facts['os_service_default'],
  $log_options                 = $facts['os_service_default'],
  $run_external_periodic_tasks = $facts['os_service_default'],
) {

  $service_options = {
    'DEFAULT/backdoor_port'               => { value => $backdoor_port },
    'DEFAULT/backdoor_socket'             => { value => $backdoor_socket },
    'DEFAULT/graceful_shutdown_timeout'   => { value => $graceful_shutdown_timeout },
    'DEFAULT/log_options'                 => { value => $log_options },
    'DEFAULT/run_external_periodic_tasks' => { value => $run_external_periodic_tasks },
  }

  create_resources($name, $service_options)
}
