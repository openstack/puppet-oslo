# == Class: oslo::config
#
# This class is used to manage arbitrary oslo configurations.
#
# === Parameters
#
# [*oslo_config*]
#   (optional) Allow configuration of arbitrary oslo configurations.
#   The value is an hash of oslo_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   oslo_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class oslo::config (
  $oslo_config = {},
) {

  validate_hash($oslo_config)

  create_resources('oslo_config', $oslo_config)
}
