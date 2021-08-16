# == Define: oslo::reports
#
# Configure oslo_reports options
#
# === Parameters
#
# [*config*]
#   (Optional) The resource type used to apply configuration parameters.
#   Defaults to $name
#
# [*log_dir*]
#   (Optional) Path to a log directory where to create a file
#   Defaults to $facts['os_service_default']
#
# [*file_event_handler*]
#   (Optional) The path to a file to watch for changes to trigger the reports.
#   Defaults to $facts['os_service_default']
#
# [*file_event_handler_interval*]
#   (Optional) How many seconds to wait between pools when file_event_handler
#   is set.
#   Defaults to $facts['os_service_default']
#
define oslo::reports(
  $config                      = $name,
  $log_dir                     = $facts['os_service_default'],
  $file_event_handler          = $facts['os_service_default'],
  $file_event_handler_interval = $facts['os_service_default'],
) {

  $oslo_reports_options = {
    'oslo_reports/log_dir'                     => { value => $log_dir },
    'oslo_reports/file_event_handler'          => { value => $file_event_handler },
    'oslo_reports/file_event_handler_interval' => { value => $file_event_handler_interval },
  }

  create_resources($config, $oslo_reports_options)
}
