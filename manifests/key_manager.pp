# == Define: oslo::key_manager
#
# Configure key_manager options implemented in the castellan library
#
# === Parameters
#
# [*config*]
#   (Optional) The resource type used to apply configuration parameters.
#   Defaults to $name
#
# [*backend*]
#   (Optional) Specify the key manager implementation.
#   Defaults to $::os_service_default
#
define oslo::key_manager(
  $config  = $name,
  $backend = $::os_service_default,
) {

  $key_manager_options = {
    'key_manager/backend' => { value => $backend },
  }

  create_resources($config, $key_manager_options)
}
