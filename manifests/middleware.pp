# == Define: oslo::middleware
#
# Configure oslo_middleware options
#
# This resource configures oslo.middleware resources for an OpenStack service.
# It will manage the [oslo_middleware] section in the given config resource.
#
# === Parameters:
#
# [*max_request_body_size*]
#   (Optional) Make exception message format errors fatal.
#   (integer value)
#   Defaults to $::os_service_default.
#
define oslo::middleware(
  $max_request_body_size = $::os_service_default,
) {
  $middleware_options = {
    'oslo_middleware/max_request_body_size' => { value => $max_request_body_size }
  }
  create_resources($name, $middleware_options)
}
