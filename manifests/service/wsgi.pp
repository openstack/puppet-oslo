# == Define: oslo::service::wsgi
#
# Configure oslo_service options
#
# This resource configures wsgi service parameters of oslo.service library.
#
# === Parameters:
#
# [*api_paste_config*]
#   (optional) File name for the paste.deploy config for api service.
#   (string value)
#   Defaults to $::os_service_default.
#
# [*client_socket_timeout*]
#   (optional) Timeout for client connections' socket operations. A value of
#   '0' means wait forever. (integer value)
#   Defaults to $::os_service_default.
#
# [*max_header_line*]
#   (optional) Maximum line size of message headers to be accepted.
#   (integer value)
#   Defaults to $::os_service_default.
#
# [*tcp_keepidle*]
#   (optional) # Sets the value of TCP_KEEPIDLE in seconds for each server socket.
#   (integer value)
#   Defaults to $::os_service_default.
#
# [*wsgi_default_pool_size*]
#   (optional) Size of the pool of greenthreads used by wsgi (integer value)
#   Defaults to $::os_service_default.
#
# [*wsgi_keep_alive*]
#   (optional) If False, closes the client socket connection explicitly.
#   (boolean value)
#   Defaults to $::os_service_default.
#
# [*wsgi_log_format*]
#   (optional) A python format string that is used as the template to generate
#   log lines. (string value)
#   Defaults to $::os_service_default.
#   Example: '%(client_ip)s "%(request_line)s" status: %(status_code)s len: \
#             %(body_length)s time: %(wall_seconds).7f'
#
define oslo::service::wsgi (
  $api_paste_config       = $::os_service_default,
  $client_socket_timeout  = $::os_service_default,
  $max_header_line        = $::os_service_default,
  $tcp_keepidle           = $::os_service_default,
  $wsgi_default_pool_size = $::os_service_default,
  $wsgi_keep_alive        = $::os_service_default,
  $wsgi_log_format        = $::os_service_default,
) {

  $service_options = {
    'DEFAULT/api_paste_config'       => { value => $api_paste_config },
    'DEFAULT/client_socket_timeout'  => { value => $client_socket_timeout },
    'DEFAULT/max_header_line'        => { value => $max_header_line },
    'DEFAULT/tcp_keepidle'           => { value => $tcp_keepidle },
    'DEFAULT/wsgi_default_pool_size' => { value => $wsgi_default_pool_size },
    'DEFAULT/wsgi_keep_alive'        => { value => $wsgi_keep_alive },
    'DEFAULT/wsgi_log_format'        => { value => $wsgi_log_format },
  }

  create_resources($name, $service_options)
}
