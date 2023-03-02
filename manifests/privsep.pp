# == Define: oslo::privsep
#
# Configure oslo_privsep options
#
# This resource configures Oslo privilege separator resources for an OpenStack service.
# It will manage the [privsep_${entrypoint}] section in the given config resource.
#
# === Parameters:
#
# [*entrypoint*]
#  (Required) Privsep entrypoint. (string value)
#  Defaults to $name.
#
# [*config*]
#  (Required) Configuration file to manage. (string value)
#
# [*config_group*]
#  (Optional) Name of the section in which the parameters are set.
#  (string value)
#  Defaults to "privsep_${entrypoint}"
#
# [*user*]
#  (Optional) User that the privsep daemon should run as. (string value)
#  Defaults to $facts['os_service_default'].
#
# [*group*]
#  (Optional) Group that the privsep daemon should run as. (string value)
#  Defaults to $facts['os_service_default'].
#
# [*capabilities*]
#  (Optional) List of Linux capabilities retained by the privsep daemon.
#  (list value)
#  Defaults to $facts['os_service_default'].
#
# [*thread_pool_size*]
#  (Optional) The number of threads available for privsep to concurrently
#  run processes.
#  Defaults to $facts['os_service_default'].
#
# [*helper_command*]
#  (Optional) Command to invoke to start the privsep daemon if not using
#  the "fork" method. If not specified, a default is generated using
#  "sudo privsep-helper" and arguments designed to recreate the current
#  configuration. This command must accept suitable --privsep_context and
#  --privsep_sock_path arguments.
#  Defaults to $facts['os_service_default'].
#
# [*logger_name*]
#  (Optional) Logger name to use for this privsep context.
#  Defaults to $facts['os_service_default'].
#
# == Examples
#
#   oslo::privsep { 'osbrick':
#     config => 'nova_config'
#   }
#
define oslo::privsep (
  $config,
  $entrypoint       = $name,
  $config_group     = "privsep_${entrypoint}",
  $user             = $facts['os_service_default'],
  $group            = $facts['os_service_default'],
  $capabilities     = $facts['os_service_default'],
  $thread_pool_size = $facts['os_service_default'],
  $helper_command   = $facts['os_service_default'],
  $logger_name      = $facts['os_service_default'],
) {

  $privsep_options = {
    "${config_group}/user"             => { value => $user },
    "${config_group}/group"            => { value => $group },
    "${config_group}/capabilities"     => { value => $capabilities },
    "${config_group}/thread_pool_size" => { value => $thread_pool_size },
    "${config_group}/helper_command"   => { value => $helper_command },
    "${config_group}/logger_name"      => { value => $logger_name },
  }

  create_resources($config, $privsep_options)
}
