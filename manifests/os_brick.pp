# == Define: oslo::os_brick
#
# Configure os_brick options
#
# === Parameters:
#
# [*lock_path*]
#   (Optional) Directory to use for os-brick lock files.
#   Defaults to $facts['os_service_default']
#
# [*wait_mpath_device_attempts*]
#   (Optional) Number of attempts for the multipath device to be ready for I/O
#   after it was created.
#   Defaults to $facts['os_service_default']
#
# [*wait_mpath_device_interval*]
#   (Optional) Interval value to wait for multipath device to be ready for I/O.
#   Defaults to $facts['os_service_default']
#
define oslo::os_brick (
  $lock_path                  = $facts['os_service_default'],
  $wait_mpath_device_attempts = $facts['os_service_default'],
  $wait_mpath_device_interval = $facts['os_service_default'],
) {
  $os_brick_options = {
    'os_brick/lock_path'                  => { value => $lock_path },
    'os_brick/wait_mpath_device_attempts' => { value => $wait_mpath_device_attempts },
    'os_brick/wait_mpath_device_interval' => { value => $wait_mpath_device_interval },
  }
  create_resources($name, $os_brick_options)
}
