# == Define: oslo::limit
#
# Configure oslo_limit options
#
# === Parameters:
#
# [*endpoint_id*]
#   (Required) The service's endpoint id which is registered in Keystone.
#
# [*username*]
#   (Required) The name of the service user
#
# [*password*]
#   (Required) Password to create for the service user
#
# [*auth_url*]
#   (Required) The URL to use for authentication.
#
# [*project_name*]
#   (Required) Service project name
#
# [*user_domain_name*]
#   (Optional) Name of domain for $username
#   Defaults to 'Default'.
#
# [*project_domain_name*]
#   (Optional) Name of domain for $project_name
#   Defaults to 'Default'.
#
# [*system_scope*]
#   (Optional) Scope for system operations.
#   Defaults to $facts['os_service_default']
#
# [*auth_type*]
#  (Optional) Authentication type to load
#  Defaults to 'password'.
#
# [*service_type*]
#  (Optional) The name or type of the service as it appears in the service
#  catalog. This is used to validate tokens that have restricted access rules.
#  Defaults to $facts['os_service_default'].
#
# [*valid_interfaces*]
#  (Optional) List of interfaces, in order of preference, for endpoint URL.
#  Defaults to $facts['os_service_default'].
#
# [*region_name*]
#  (Optional) The region in which the identity server can be found.
#  Defaults to $facts['os_service_default'].
#
# [*endpoint_override*]
#  (Optional) Always use this endpoint URL for requests for this client.
#  Defaults to $facts['os_service_default'].
#
define oslo::limit(
  $endpoint_id,
  $username,
  $password,
  $auth_url,
  $project_name        = $facts['os_service_default'],
  $user_domain_name    = 'Default',
  $project_domain_name = 'Default',
  $system_scope        = $facts['os_service_default'],
  $auth_type           = 'password',
  $service_type        = $facts['os_service_default'],
  $valid_interfaces    = $facts['os_service_default'],
  $region_name         = $facts['os_service_default'],
  $endpoint_override   = $facts['os_service_default'],
) {

  if is_service_default($system_scope) {
    $project_name_real        = $project_name
    $project_domain_name_real = $project_domain_name
  } else {
    # When system scope is used, project parameters should be removed otherwise
    # project scope is used.
    $project_name_real        = $facts['os_service_default']
    $project_domain_name_real = $facts['os_service_default']
  }

  $limit_options = {
    'oslo_limit/endpoint_id'         => { value => $endpoint_id },
    'oslo_limit/username'            => { value => $username },
    'oslo_limit/password'            => { value => $password, secret => true },
    'oslo_limit/auth_url'            => { value => $auth_url },
    'oslo_limit/project_name'        => { value => $project_name_real },
    'oslo_limit/user_domain_name'    => { value => $user_domain_name },
    'oslo_limit/project_domain_name' => { value => $project_domain_name_real },
    'oslo_limit/system_scope'        => { value => $system_scope },
    'oslo_limit/auth_type'           => { value => $auth_type },
    'oslo_limit/service_type'        => { value => $service_type },
    'oslo_limit/valid_interfaces'    => { value => join(any2array($valid_interfaces), ',') },
    'oslo_limit/region_name'         => { value => $region_name },
    'oslo_limit/endpoint_override'   => { value => $endpoint_override },
  }
  create_resources($name, $limit_options)
}
