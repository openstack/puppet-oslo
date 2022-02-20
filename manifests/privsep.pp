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
#  (Optional) Name of the section in which the parameters are set. (string value)
#  Defaults to "privsep_${entrypoint}"
#
# [*user*]
#  (Optional) User that the privsep daemon should run as. (string value)
#  Defaults to $::os_service_default.
#
# [*group*]
#  (Optional) Group that the privsep daemon should run as. (string value)
#  Defaults to $::os_service_default.
#
# [*capabilities*]
#  (Optional) List of Linux capabilities retained by the privsep daemon. (list value)
#  Defaults to $::os_service_default.
#
# [*helper_command*]
#  (Optional) Command to invoke to start the privsep daemon if not using the "fork" method.
#  If not specified, a default is generated using "sudo privsep-helper" and arguments designed to
#  recreate the current configuration. This command must accept suitable --privsep_context
#  and --privsep_sock_path arguments.
#  Defaults to $::os_service_default.
#
# == Examples
#
#   oslo::privsep { 'osbrick':
#     config => 'nova_config'
#   }
#
define oslo::privsep (
  $config,
  $entrypoint     = $name,
  $config_group   = "privsep_${entrypoint}",
  $user           = $::os_service_default,
  $group          = $::os_service_default,
  $capabilities   = $::os_service_default,
  $helper_command = $::os_service_default,
) {

  $privsep_options = {
    "${config_group}/user"           => { value => $user },
    "${config_group}/group"          => { value => $group },
    "${config_group}/capabilities"   => { value => $capabilities },
    "${config_group}/helper_command" => { value => $helper_command },
  }

  create_resources($config, $privsep_options)
}
