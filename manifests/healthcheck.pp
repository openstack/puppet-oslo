# == Define: oslo::healthcheck
#
# Configure oslo_middleware options in healthcheck section
#
# === Parameters:
#
# [*detailed*]
#   (Optional) Show more detailed information as part of the response.
#   Defaults to $facts['os_service_default']
#
# [*backends*]
#   (Optional) Additional backends that can perform health checks and report
#   that information back as part of a request.
#   Defaults to $facts['os_service_default']
#
# [*allowed_source_ranges*]
#   (Optional) A list of network addresses to limit source ip allowed to access
#   healthcheck information.
#   Defaults to $facts['os_service_default']
#
# [*ignore_proxied_requests*]
#   (Optional) Ignore requests with proxy headers
#   Defaults to $facts['os_service_default']
#
# [*disable_by_file_path*]
#   (Optional) Check the presence of a file to determine if an application
#   is running on a port.
#   Defaults to $facts['os_service_default']
#
# [*disable_by_file_paths*]
#   (Optional) Check the presence of a file to determine if an application
#   is running on a port. Expects a "port:path" list of strings.
#   Defaults to $facts['os_service_default']
#
define oslo::healthcheck(
  $detailed                = $facts['os_service_default'],
  $backends                = $facts['os_service_default'],
  $allowed_source_ranges   = $facts['os_service_default'],
  $ignore_proxied_requests = $facts['os_service_default'],
  $disable_by_file_path    = $facts['os_service_default'],
  $disable_by_file_paths   = $facts['os_service_default'],
) {

  $backends_real = join(any2array($backends), ',')
  $allowed_source_ranges_real = join(any2array($allowed_source_ranges), ',')
  $disable_by_file_paths_real = join(any2array($disable_by_file_paths), ',')

  $healthcheck_options = {
    'healthcheck/detailed'                => { value => $detailed },
    'healthcheck/backends'                => { value => $backends_real },
    'healthcheck/allowed_source_ranges'   => { value => $allowed_source_ranges_real },
    'healthcheck/ignore_proxied_requests' => { value => $ignore_proxied_requests },
    'healthcheck/disable_by_file_path'    => { value => $disable_by_file_path },
    'healthcheck/disable_by_file_paths'   => { value => $disable_by_file_paths_real },
  }
  create_resources($name, $healthcheck_options)
}
