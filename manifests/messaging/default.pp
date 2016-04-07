# == Define: oslo::messaging::default
#
# Configure oslo DEFAULT messaging options
#
# It will manage the [DEFAULT] section in the given config resource.
#
# === Parameters:
#
# [*transport_url*]
#   (Optional) A URL representing the messaging driver to use
#   and its full configuration. If not set, we fall back to
#   the rpc_backend option and driver specific configuration.
#   (string value)
#   Defaults to $::os_service_default.
#
# [*control_exchange*]
#   (Optional) The default exchange under which topics are scoped.
#   May be overridden by an exchange name specified in the transport_url option.
#   (string value)
#   Defaults to $::os_service_default.
#

define oslo::messaging::default(
  $transport_url    = $::os_service_default,
  $control_exchange = $::os_service_default,
) {

  $default_options = {
    'DEFAULT/transport_url'    => { value => $transport_url },
    'DEFAULT/control_exchange' => { value => $control_exchange },
  }

  create_resources($name, $default_options)
}
