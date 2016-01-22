# == Define: oslo::log
#
# Configure oslo_log options
#
# This resource configures Oslo logging resources for an OpenStack service.
# It will manage the [DEFAULT] section in the given config resource.
#
# === Parameters:
#
# [*debug*]
#   (Optional) Should the daemons log debug messages
#   Defaults to $::os_service_default
#
# [*verbose*]
#   (Optional) Should the daemons log verbose messages
#   Defaults to $::os_service_default
#
# [*log_config_append*]
#   The name of an additional logging configuration file.
#   Defaults to $::os_service_default
#   See https://docs.python.org/2/howto/logging.html
#
# [*log_date_format*]
#   (Optional) Format string for %%(asctime)s in log records.
#   Defaults to $::os_service_default
#   Example: 'Y-%m-%d %H:%M:%S'
#
# [*log_file*]
#   (Optional) Name of log file to output to. If no default is set, logging will go to stdout.
#   This option is ignored if log_config_append is set.
#   Defaults to $::os_service_default
#
# [*log_dir*]
#   (Optional) Directory where logs should be stored.
#   If set to boolean false, it will not log to any directory.
#   Defaults to $::os_service_default
#
# [*watch_log_file*]
#   (Optional) Uses logging handler designed to watch file system (boolean value).
#   Defaults to $::os_service_default
#
# [*use_syslog*]
#   (Optional) Use syslog for logging (boolean value).
#   Defaults to $::os_service_default
#
# [*use_syslog_rfc_format*]
#   (Optional) Enables or disables syslog rfc5424 format for logging (boolean value).
#   Defaults to $::os_service_default
#
# [*syslog_log_facility*]
#   (Optional) Syslog facility to receive log lines.
#   This option is ignored if log_config_append is set.
#   Defaults to $::os_service_default
#
# [*use_stderr*]
#   (Optional) Log output to standard error.
#   This option is ignored if log_config_append is set.
#   Defaults to $::os_service_default
#
# [*logging_context_format_string*]
#   (Optional) Format string to use for log messages with context.
#   Defaults to $::os_service_default
#   Example: '%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s \
#             [%(request_id)s %(user_identity)s] %(instance)s%(message)s'
#
# [*logging_default_format_string*]
#   (Optional) Format string to use for log messages when context is undefined.
#   Defaults to $::os_service_default
#   Example:  '%(asctime)s.%(msecs)03d %(process)d %(levelname)s \
#              %(name)s [-] %(instance)s%(message)s'
#
# [*logging_debug_format_suffix*]
#   (Optional) Additional data to append to log message when logging level for the message is DEBUG'
#   Defaults to $::os_service_default
#   Example: '%(funcName)s %(pathname)s:%(lineno)d'
#
# [*logging_exception_prefix*]
#   (Optional) Prefix each line of exception output with this format.
#   Defaults to $::os_service_default
#   Example: '%(asctime)s.%(msecs)03d %(process)d ERROR %(name)s %(instance)s'
#
# [*logging_user_identity_format*]
#   (Optional) Defines the format string for %(user_identity)s that is used in logging_context_format_string.
#   Defaults to $::os_service_default
#   Example: '%(user)s %(tenant)s %(domain)s %(user_domain)s %(project_domain)s'
#
# [*default_log_levels*]
#   (Optional) Hash of logger (keys) and level (values) pairs.
#   Defaults to $::os_service_default
#   Example:
#     { 'amqp' => 'WARN', 'amqplib' => 'WARN', 'boto' => 'WARN',
#       'qpid' => 'WARN', 'sqlalchemy' => 'WARN', 'suds' => 'INFO',
#       'iso8601' => 'WARN',
#       'requests.packages.urllib3.connectionpool' => 'WARN' }
#
# [*publish_errors*]
#   (Optional) Enables or disables publication of error events (boolean value).
#   Defaults to $::os_service_default.
#
# [*instance_format*]
#   (Optional) The format for an instance that is passed with the log message.
#   Defaults to $::os_service_default
#   Example: '[instance: %(uuid)s] '
#
# [*instance_uuid_format*]
#   (Optional) The format for an instance UUID that is passed with the log message.
#   Defaults to $::os_service_default
#   Example: '[instance: %(uuid)s] '
#
# [*fatal_deprecations*]
#   (Optional) Enables or disables fatal status of deprecations (boolean value).
#   Defaults to $::os_service_default.
#
# DEPRECATED:
# [*log_format*]
#   (Optional) DEPRECATED. A logging.Formatter log message format string which may use
#   any of the available logging.LogRecord attributes.
#   Defauls to $::os_service_default
#
define oslo::log(
  $debug                         = $::os_service_default,
  $verbose                       = $::os_service_default,
  $log_config_append             = $::os_service_default,
  $log_date_format               = $::os_service_default,
  $log_file                      = $::os_service_default,
  $log_dir                       = $::os_service_default,
  $watch_log_file                = $::os_service_default,
  $use_syslog                    = $::os_service_default,
  $use_syslog_rfc_format         = $::os_service_default,
  $syslog_log_facility           = $::os_service_default,
  $use_stderr                    = $::os_service_default,
  $logging_context_format_string = $::os_service_default,
  $logging_default_format_string = $::os_service_default,
  $logging_debug_format_suffix   = $::os_service_default,
  $logging_exception_prefix      = $::os_service_default,
  $logging_user_identity_format  = $::os_service_default,
  $default_log_levels            = $::os_service_default,
  $publish_errors                = $::os_service_default,
  $instance_format               = $::os_service_default,
  $instance_uuid_format          = $::os_service_default,
  $fatal_deprecations            = $::os_service_default,
  # DEPRECATED
  $log_format                    = $::os_service_default,
){

  # Deprecated options
  if ! is_service_default($log_format) {
    warnning('This option is deprecated. Please use logging_context_format_string and logging_default_format_string instead.')
  }

  if is_service_default($default_log_levels) {
    $default_log_levels_real = $default_log_levels
  } else {
    validate_hash($default_log_levels)
    $default_log_levels_real = join(sort(join_keys_to_values($default_log_levels, '=')), ',')
  }

  create_resources($name, {'DEFAULT/debug'                         => { value => $debug }})
  create_resources($name, {'DEFAULT/verbose'                       => { value => $verbose }})
  create_resources($name, {'DEFAULT/log_config_append'             => { value => $log_config_append }})
  create_resources($name, {'DEFAULT/log_date_format'               => { value => $log_date_format }})
  create_resources($name, {'DEFAULT/log_file'                      => { value => $log_file }})
  create_resources($name, {'DEFAULT/log_dir'                       => { value => $log_dir }})
  create_resources($name, {'DEFAULT/watch_log_file'                => { value => $watch_log_file }})
  create_resources($name, {'DEFAULT/use_syslog'                    => { value => $use_syslog }})
  create_resources($name, {'DEFAULT/use_syslog_rfc_format'         => { value => $use_syslog_rfc_format }})
  create_resources($name, {'DEFAULT/syslog_log_facility'           => { value => $syslog_log_facility }})
  create_resources($name, {'DEFAULT/use_stderr'                    => { value => $use_stderr }})
  create_resources($name, {'DEFAULT/logging_context_format_string' => { value => $logging_context_format_string }})
  create_resources($name, {'DEFAULT/logging_default_format_string' => { value => $logging_default_format_string }})
  create_resources($name, {'DEFAULT/logging_debug_format_suffix'   => { value => $logging_debug_format_suffix }})
  create_resources($name, {'DEFAULT/logging_exception_prefix'      => { value => $logging_exception_prefix }})
  create_resources($name, {'DEFAULT/logging_user_identity_format'  => { value => $logging_user_identity_format }})
  create_resources($name, {'DEFAULT/default_log_levels'            => { value => $default_log_levels_real }})
  create_resources($name, {'DEFAULT/publish_errors'                => { value => $publish_errors }})
  create_resources($name, {'DEFAULT/instance_format'               => { value => $instance_format }})
  create_resources($name, {'DEFAULT/instance_uuid_format'          => { value => $instance_uuid_format }})
  create_resources($name, {'DEFAULT/fatal_deprecations'            => { value => $fatal_deprecations }})
  create_resources($name, {'DEFAULT/log_format'                    => { value => $log_format }})
}
