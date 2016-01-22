# == Define: oslo::log
#
# Configure oslo_log options
#
# This resource configures Oslo logging resources for an OpenStack service.
# It will manage the [DEFAULT] section in the given config resource.
#
# === Parameters:
#
# [*use_stderr*]
#   (Optional) Log output to standard error. This option is ignored if log_config_append is set.
#   Defaults to True.
#
# [*logging_context_format_string*]
#   (Optional) Format string to use for log messages with context.
#   Defaults to '%(asctime)s.%(msecs)03d %(process)d %(levelname)s'
#               '%(name)s [%(request_id)s %(user_identity)s] '
#               '%(instance)s%(message)s'
#
# [*logging_default_format_string*]
#   (Optional) Format string to use for log messages when context is undefined.
#   Defaults to '%(asctime)s.%(msecs)03d %(process)d %(levelname)s '
#               '%(name)s [-] %(instance)s%(message)s'
#
# [*logging_debug_format_suffix*]
#   (Optional) Additional data to append to log message when logging level for the message is DEBUG'
#   Defaults to '%(funcName)s %(pathname)s:%(lineno)d'
#
# [*logging_exception_prefix*]
#   (Optional) Prefix each line of exception output with this format.
#   Defaults to '%(asctime)s.%(msecs)03d %(process)d ERROR %(name)s %(instance)s'
#
# [*logging_user_identity_format*]
#   (Optional) Defines the format string for %(user_identity)s that is used in logging_context_format_string.
#   Defaults to '%(user)s %(tenant)s %(domain)s %(user_domain)s %(project_domain)s'
#
# [*default_log_levels*]
#   (Optional) List of package logging levels in logger=LEVEL pairs.
#   This option is ignored if log_config_append is set.
#   Defaults to amqp=WARN, amqplib=WARN, boto=WARN,
#               qpid=WARN, sqlalchemy=WARN, suds=INFO,
#               oslo.messaging=INFO, iso8601=WARN,
#               requests.packages.urllib3.connectionpool=WARN,
#               urllib3.connectionpool=WARN, websocket=WARN,
#               requests.packages.urllib3.util.retry=WARN,
#               urllib3.util.retry=WARN,
#               keystonemiddleware=WARN, 'routes.middleware=WARN',
#               stevedore=WARN, taskflow=WARN,
#               keystoneauth=WARN
#
# [*publish_errors*]
#   (Optional) Enables or disables publication of error events.
#   Defaults to False.
#
# [*instance_format*]
#   (Optional) The format for an instance that is passed with the log message.
#   Defaults to "[instance: %(uuid)s] "
#
# [*instance_uuid_format*]
#   (Optional) The format for an instance UUID that is passed with the log message.
#   Defaults to "[instance: %(uuid)s] "
#
define oslo::log(
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
){
  create_resources($name, {'DEFAULT/use_stderr'                    => { value => $use_stderr }})
  create_resources($name, {'DEFAULT/logging_context_format_string' => { value => $logging_context_format_string }})
  create_resources($name, {'DEFAULT/logging_default_format_string' => { value => $logging_default_format_string }})
  create_resources($name, {'DEFAULT/logging_debug_format_suffix'   => { value => $logging_debug_format_suffix }})
  create_resources($name, {'DEFAULT/logging_exception_prefix'      => { value => $logging_exception_prefix }})
  create_resources($name, {'DEFAULT/logging_user_identity_format'  => { value => $logging_user_identity_format }})
  create_resources($name, {'DEFAULT/default_log_levels'            => { value => $default_log_levels }})
  create_resources($name, {'DEFAULT/publish_errors'                => { value => $publish_errors }})
  create_resources($name, {'DEFAULT/instance_format'               => { value => $instance_format }})
  create_resources($name, {'DEFAULT/instance_uuid_format'          => { value => $instance_uuid_format }})
}
