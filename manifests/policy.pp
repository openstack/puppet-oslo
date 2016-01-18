# == Class: oslo::policy
#
# Configure the oslo policies
#
# === Parameters
#
# [*policies*]
#   (optional) Set of policies to configure for oslo
#   Example :
#     {
#       'oslo-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'oslo-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (optional) Path to the nova policy.json file
#   Defaults to /etc/oslo/policy.json
#
class oslo::policy (
  $policies    = {},
  $policy_path = '/etc/oslo/policy.json',
) {

  validate_hash($policies)

  Openstacklib::Policy::Base {
    file_path => $policy_path,
  }

  create_resources('openstacklib::policy::base', $policies)

}
