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
#   Defaults to $facts['os_service_default'].
#
# [*enable_proxy_headers_parsing*]
#   (Optional) Enables SSL request handling from HTTPProxyToWSGI middleware.
#   (boolean value)
#   Defaults to $facts['os_service_default'].
#
# [*http_basic_auth_user_file*]
#   (Optional) HTTP basic auth password file.
#   (string value)
#   Defaults to $facts['os_service_default'].
#
define oslo::middleware (
  # sizelimit
  $max_request_body_size        = $facts['os_service_default'],
  # http_proxy_to_wsgi
  $enable_proxy_headers_parsing = $facts['os_service_default'],
  # basic_auth
  $http_basic_auth_user_file    = $facts['os_service_default'],
) {
  $middleware_options = {
    'oslo_middleware/max_request_body_size'        => { value => $max_request_body_size },
    'oslo_middleware/enable_proxy_headers_parsing' => { value => $enable_proxy_headers_parsing },
    'oslo_middleware/http_basic_auth_user_file'    => { value => $http_basic_auth_user_file },
  }
  create_resources($name, $middleware_options)
}
