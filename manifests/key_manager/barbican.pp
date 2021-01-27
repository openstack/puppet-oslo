# == Define: oslo::key_manager::barbican
#
# Setup and configure Barbican Key Manager options
#
# === Parameters
#
# [*config*]
#   (Optional) The resource type used to apply configuration parameters.
#   Defaults to $name
#
# [*barbican_endpoint*]
#   (Optional) Use this endpoint to connect to Barbican.
#   Defaults to $::os_service_default
#
# [*barbican_api_version*]
#   (Optional) Version of the Barbican API.
#   Defaults to $::os_service_default
#
# [*auth_endpoint*]
#   (Optional) Use this endpoint to connect to Keystone.
#   Defaults to $::os_service_default
#
# [*retry_delay*]
#   (Optional) Number of seconds to wait before retrying poll for key creation
#   completion.
#   Defaults to $::os_service_default
#
# [*number_of_retries*]
#   (Optional) Number of times to retry poll fo key creation completion.
#   Defaults to $::os_service_default
#
# [*barbican_endpoint_type*]
#   (Optional) Specifies the type of endpoint.
#   Defaults to $::os_service_default
#
# [*barbican_region_name*]
#   (Optional) Specifies the region of the chosen endpoint.
#   Defaults to $::os_service_default
#
define oslo::key_manager::barbican (
  $config                 = $name,
  $barbican_endpoint      = $::os_service_default,
  $barbican_api_version   = $::os_service_default,
  $auth_endpoint          = $::os_service_default,
  $retry_delay            = $::os_service_default,
  $number_of_retries      = $::os_service_default,
  $barbican_endpoint_type = $::os_service_default,
  $barbican_region_name   = $::os_service_default,
) {

  $barbican_options = {
    'barbican/barbican_endpoint'      => { value => $barbican_endpoint },
    'barbican/barbican_api_version'   => { value => $barbican_api_version },
    'barbican/auth_endpoint'          => { value => $auth_endpoint },
    'barbican/retry_delay'            => { value => $retry_delay },
    'barbican/number_of_retries'      => { value => $number_of_retries },
    'barbican/barbican_endpoint_type' => { value => $barbican_endpoint_type },
    'barbican/barbican_region_name'   => { value => $barbican_region_name },
  }

  create_resources($config, $barbican_options)
}
