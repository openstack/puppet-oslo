# == Define: oslo::healthcheck
#
# Configure oslo_middleware options in healthcheck section
#
# === Parameters:
#
# [*detailed*]
#   (Optional) Show more detailed information as part of the response.
#   Defaults to $::os_service_default
#
# [*backends*]
#   (Optional) Additional backends that can perform health checks and report
#   that information back as part of a request.
#   Defaults to $::os_service_default
#
# [*disable_by_file_path*]
#   (Optional) Check the presence of a file to determine if an application
#   is running on a port.
#   Defaults to $::os_service_default
#
# [*disable_by_file_paths*]
#   (Optional) Check the presence of a file to determine if an application
#   is running on a port. Expects a "port:path" list of strings.
#   Defaults to $::os_service_default
#
define oslo::healthcheck(
  $detailed              = $::os_service_default,
  $backends              = $::os_service_default,
  $disable_by_file_path  = $::os_service_default,
  $disable_by_file_paths = $::os_service_default,
) {

  $backends_real = join(any2array($backends), ',')
  $disable_by_file_paths_real = join(any2array($disable_by_file_paths), ',')

  $healthcheck_options = {
    'healthcheck/detailed'              => { value => $detailed },
    'healthcheck/backends'              => { value => $backends_real },
    'healthcheck/disable_by_file_path'  => { value => $disable_by_file_path },
    'healthcheck/disable_by_file_paths' => { value => $disable_by_file_paths_real},
  }
  create_resources($name, $healthcheck_options)
}
