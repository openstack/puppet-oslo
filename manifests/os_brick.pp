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
define oslo::os_brick(
  $lock_path = $facts['os_service_default'],
) {

  $os_brick_options = {
    'os_brick/lock_path' => { value => $lock_path },
  }
  create_resources($name, $os_brick_options)
}
