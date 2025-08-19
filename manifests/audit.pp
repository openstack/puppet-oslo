# == Define: oslo::audit
#
# Configure audit middleware options
#
# == Params
#
# [*config*]
#   (Optional) The resource type used to apply configuration parameters.
#   Defaults to $name
#
# [*audit_map_file*]
#   (Optional) Path to audit map file.
#   Defaults to $facts['os_service_default']
#
# [*ignore_req_list*]
#   (Optional) List of REST API HTTP methods to be ignored during audit
#   logging.
#   Defaults to $facts['os_service_default']
#
define oslo::audit (
  $config          = $name,
  $audit_map_file  = $facts['os_service_default'],
  $ignore_req_list = $facts['os_service_default'],
) {
  $options = {
    'audit/audit_map_file'  => { 'value' => $audit_map_file },
    'audit/ignore_req_list' => { 'value' => join(any2array($ignore_req_list), ',') },
  }
  create_resources($config, $options)
}
