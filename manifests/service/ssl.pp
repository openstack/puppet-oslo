# == Define: oslo::service::ssl
#
# Configure oslo_service options
#
# This resource configures ssl parameters of oslo.service library
#
# === Parameters:
#
# [*ca_file*]
#   (optional) CA certificate file to use to verify connecting clients.
#   (string value)
#   Defaults to $facts['os_service_default'].
#
# [*cert_file*]
#   (optional) Certificate file to use when starting the server securely.
#   (string value)
#   Defaults to $facts['os_service_default'].
#
# [*ciphers*]
#   (optional) Sets the list of available ciphers. value should be a string
#   in the OpenSSL cipher list format. (string value)
#   Defaults to $facts['os_service_default'].
#
# [*key_file*]
#   (optional) Private key file to use when starting the server securely.
#   (string value)
#   Defaults to $facts['os_service_default'].
#
# [*version*]
#   (optional) SSL version to use (valid only if SSL enabled). Valid values are
#   TLSv1 and SSLv23. SSLv2, SSLv3, TLSv1_1, and TLSv1_2 may be available on
#   some distributions. (string value)
#   Defaults to $facts['os_service_default'].
#
define oslo::service::ssl (
  $ca_file   = $facts['os_service_default'],
  $cert_file = $facts['os_service_default'],
  $ciphers   = $facts['os_service_default'],
  $key_file  = $facts['os_service_default'],
  $version   = $facts['os_service_default'],
) {
  if is_service_default($cert_file) != is_service_default($key_file) {
    fail('Both of cert_file and key_file should be set or unset.')
  }

  $service_options = {
    'ssl/ca_file'   => { value => $ca_file },
    'ssl/cert_file' => { value => $cert_file },
    'ssl/ciphers'   => { value => join(any2array($ciphers), ':') },
    'ssl/key_file'  => { value => $key_file },
    'ssl/version'   => { value => $version },
  }
  create_resources($name, $service_options)
}
