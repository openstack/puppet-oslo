# == Define: oslo::messaging::notifications
#
# Configure oslo_messaging_notifications options
#
# This resource configures Oslo Notifications resources for an OpenStack service.
# It will manage the [oslo_messaging_notifications] section in the given config resource.
#
# === Parameters:
#
# [*driver*]
#   (Optional) The Driver(s) to handle sending notifications.
#   Possible values are messaging, messagingv2, routing, log, test, noop.
#   (list value or string value)
#   Defaults to $facts['os_service_default'].
#
# [*transport_url*]
#   (Optional) A URL representing the messaging driver to use for
#   notifications. If not set, we fall back to the same
#   configuration used for RPC.
#   Transport URLs take the form::
#      transport://user:pass@host1:port[,hostN:portN]/virtual_host
#   (string value)
#   Defaults to $facts['os_service_default'].
#
# [*topics*]
#   (Optional) AMQP topic(s) used for OpenStack notifications
#   (list value)
#   Defaults to $facts['os_service_default'].
#
# [*retry*]
#   (Optional) The maximum number of attempts to re-sent a notification
#   message, which failed to be delivered due to a recoverable error.
#   Defaults to $facts['os_service_default'].
#
define oslo::messaging::notifications (
  $driver                           = $facts['os_service_default'],
  Oslo::TransportURL $transport_url = $facts['os_service_default'],
  $topics                           = $facts['os_service_default'],
  $retry                            = $facts['os_service_default'],
) {
  # When we have a string value for driver,  we keep passing it as string
  # to reduce any chance of breaking things in a backwards incompatible way
  $driver_real = $driver ? {
    String  => $driver,
    default => any2array($driver)
  }

  $topics_real = join(any2array($topics), ',')

  $notification_options = {
    'oslo_messaging_notifications/driver'        => { value => $driver_real },
    'oslo_messaging_notifications/transport_url' => { value => $transport_url, secret => true },
    'oslo_messaging_notifications/topics'        => { value => $topics_real },
    'oslo_messaging_notifications/retry'         => { value => $retry },
  }

  create_resources($name, $notification_options)
}
