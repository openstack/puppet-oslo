# == Define: oslo::versionedobjects
#
# Configure oslo_versionedobjects options
#
# This resource configures oslo.versionedobjects resources for an OpenStack service.
# It will manage the [oslo_versionedobjects] section in the given config resource.
#
# === Parameters:
#
# [*fatal_exception_format_errors*]
#  (Optional) Make exception message format errors fatal. (boolean value)
#  Defaults to $facts['os_service_default'].
#
define oslo::versionedobjects (
  $fatal_exception_format_errors = $facts['os_service_default'],
) {
  $ovo_options = {
    'oslo_versionedobjects/fatal_exception_format_errors' => { value => $fatal_exception_format_errors },
  }
  create_resources($name, $ovo_options)
}
