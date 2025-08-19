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
#   Defaults to $facts['os_service_default']
#
# [*barbican_api_version*]
#   (Optional) Version of the Barbican API.
#   Defaults to $facts['os_service_default']
#
# [*auth_endpoint*]
#   (Optional) Use this endpoint to connect to Keystone.
#   Defaults to $facts['os_service_default']
#
# [*retry_delay*]
#   (Optional) Number of seconds to wait before retrying poll for key creation
#   completion.
#   Defaults to $facts['os_service_default']
#
# [*number_of_retries*]
#   (Optional) Number of times to retry poll fo key creation completion.
#   Defaults to $facts['os_service_default']
#
# [*barbican_endpoint_type*]
#   (Optional) Specifies the type of endpoint.
#   Defaults to $facts['os_service_default']
#
# [*barbican_region_name*]
#   (Optional) Specifies the region of the chosen endpoint.
#   Defaults to $facts['os_service_default']
#
# [*send_service_user_token*]
#   (Optional) The service uses service token feature when this is set as true.
#   Defaults to $facts['os_service_default']
#
define oslo::key_manager::barbican (
  $config                  = $name,
  $barbican_endpoint       = $facts['os_service_default'],
  $barbican_api_version    = $facts['os_service_default'],
  $auth_endpoint           = $facts['os_service_default'],
  $retry_delay             = $facts['os_service_default'],
  $number_of_retries       = $facts['os_service_default'],
  $barbican_endpoint_type  = $facts['os_service_default'],
  $barbican_region_name    = $facts['os_service_default'],
  $send_service_user_token = $facts['os_service_default'],
) {
  $barbican_options = {
    'barbican/barbican_endpoint'       => { value => $barbican_endpoint },
    'barbican/barbican_api_version'    => { value => $barbican_api_version },
    'barbican/auth_endpoint'           => { value => $auth_endpoint },
    'barbican/retry_delay'             => { value => $retry_delay },
    'barbican/number_of_retries'       => { value => $number_of_retries },
    'barbican/barbican_endpoint_type'  => { value => $barbican_endpoint_type },
    'barbican/barbican_region_name'    => { value => $barbican_region_name },
    'barbican/send_service_user_token' => { value => $send_service_user_token },
  }

  create_resources($config, $barbican_options)
}
