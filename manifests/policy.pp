# == Define: oslo::policy
#
# Configure oslo_policy options
#
# This resource configures Oslo policy resources for an OpenStack service.
# It will manage the [oslo_policy] section in the given config resource.
#
# === Parameters:
#
# [*enforce_scope*]
#  (Optional) Whether or not to enforce scope when evaluating policies.
#  Defaults to $facts['os_service_default'].
#
# [*enforce_new_defaults*]
#  (Optional) Whether or not to use old deprecated defaults when evaluating
#  policies.
#  Defaults to $facts['os_service_default'].
#
# [*policy_file*]
#  (Optional) The JSON file that defines policies. (string value)
#  Defaults to $facts['os_service_default'].
#
# [*policy_default_rule*]
#  (Optional) Default rule. Enforced when a requested rule is not found.
#  (string value)
#  Defaults to $facts['os_service_default'].
#
# [*policy_dirs*]
#  (Optional) Directories where policy configuration files are stored.
#  They can be relative to any directory in the search path defined by
#  the config_dir option, or absolute paths.
#  The file defined by policy_file must exist for these directories to be searched.
#  Missing or empty directories are ignored. (list value)
#  Defaults to $facts['os_service_default'].
#
define oslo::policy(
  $enforce_scope        = $facts['os_service_default'],
  $enforce_new_defaults = $facts['os_service_default'],
  $policy_file          = $facts['os_service_default'],
  $policy_default_rule  = $facts['os_service_default'],
  $policy_dirs          = $facts['os_service_default'],
) {

  $policy_options = {
    'oslo_policy/enforce_scope'        => { value => $enforce_scope },
    'oslo_policy/enforce_new_defaults' => { value => $enforce_new_defaults },
    'oslo_policy/policy_file'          => { value => $policy_file },
    'oslo_policy/policy_default_rule'  => { value => $policy_default_rule },
    'oslo_policy/policy_dirs'          => { value => $policy_dirs },
  }

  create_resources($name, $policy_options)
}
