# == Definition: oslo::key_manager::barbican::service_user
#
# Setup and configure the service token feature for Barbican Key Manager
#
# == Parameters:
#
# [*name*]
#  (Required) The name of the resource corresponding to the config file.
#  For example, oslo::key_manager::barbican::service_user { 'nova_config': ... }
#  Where 'nova_config' is the name of the resource used to manage
#  the nova configuration.
#
# [*username*]
#  (Required) The name of the service user
#
# [*password*]
#  (Required) Password to create for the service user
#
# [*auth_url*]
#  (Required) The URL to use for authentication.
#
# [*project_name*]
#  (Required) Service project name
#
# [*user_domain_name*]
#  (Optional) Name of domain for $username
#  Defaults to $::os_service_default
#
# [*project_domain_name*]
#  (Optional) Name of domain for $project_name
#  Defaults to $::os_service_default
#
# [*insecure*]
#  (Optional) If true, explicitly allow TLS without checking server cert
#  against any certificate authorities.  WARNING: not recommended.  Use with
#  caution.
#  Defaults to $::os_service_default
#
# [*auth_type*]
#  (Optional) Authentication type to load
#  Defaults to $::os_service_default
#
# [*auth_version*]
#  (Optional) API version of the admin Identity API endpoint.
#  Defaults to $::os_service_default.
#
# [*cafile*]
#  (Optional) A PEM encoded Certificate Authority to use when verifying HTTPs
#  connections.
#  Defaults to $::os_service_default.
#
# [*certfile*]
#  (Optional) Required if identity server requires client certificate
#  Defaults to $::os_service_default.
#
# [*keyfile*]
#  (Optional) Required if identity server requires client certificate
#  Defaults to $::os_service_default.
#
# [*region_name*]
#  (Optional) The region in which the identity server can be found.
#  Defaults to $::os_service_default.
#
define oslo::key_manager::barbican::service_user(
  $username,
  $password,
  $auth_url,
  $project_name,
  $user_domain_name        = $::os_service_default,
  $project_domain_name     = $::os_service_default,
  $insecure                = $::os_service_default,
  $auth_type               = $::os_service_default,
  $auth_version            = $::os_service_default,
  $cafile                  = $::os_service_default,
  $certfile                = $::os_service_default,
  $keyfile                 = $::os_service_default,
  $region_name             = $::os_service_default,
) {

  $service_user_options = {
    'barbican_service_user/auth_type'           => {'value' => $auth_type},
    'barbican_service_user/auth_version'        => {'value' => $auth_version},
    'barbican_service_user/cafile'              => {'value' => $cafile},
    'barbican_service_user/certfile'            => {'value' => $certfile},
    'barbican_service_user/keyfile'             => {'value' => $keyfile},
    'barbican_service_user/region_name'         => {'value' => $region_name},
    'barbican_service_user/auth_url'            => {'value' => $auth_url},
    'barbican_service_user/username'            => {'value' => $username},
    'barbican_service_user/password'            => {'value' => $password, 'secret' => true},
    'barbican_service_user/user_domain_name'    => {'value' => $user_domain_name},
    'barbican_service_user/project_name'        => {'value' => $project_name},
    'barbican_service_user/project_domain_name' => {'value' => $project_domain_name},
    'barbican_service_user/insecure'            => {'value' => $insecure},
  }

  create_resources($name, $service_user_options)
}
