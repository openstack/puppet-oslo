# The oslo::db::mysql class implements mysql backend for oslo
#
# This class can be used to create tables, users and grant
# privilege for a mysql oslo database.
#
# == parameters
#
# [*password*]
#   (Mandatory) Password to connect to the database.
#   Defaults to 'false'.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'oslo'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'oslo'.
#
# [*host*]
#   (Optional) The default source host user is allowed to connect from.
#   Defaults to '127.0.0.1'
#
# [*allowed_hosts*]
#   (Optional) Other hosts the user is allowed to connect from.
#   Defaults to 'undef'.
#
# [*charset*]
#   (Optional) The database charset.
#   Defaults to 'utf8'
#
# [*collate*]
#   (Optional) The database collate.
#   Only used with mysql modules >= 2.2.
#   Defaults to 'utf8_general_ci'
#
# == Dependencies
#   Class['mysql::server']
#
# == Examples
#
# == Authors
#
# == Copyright
#
class oslo::db::mysql(
  $password,
  $dbname        = 'oslo',
  $user          = 'oslo',
  $host          = '127.0.0.1',
  $charset       = 'utf8',
  $collate       = 'utf8_general_ci',
  $allowed_hosts = undef
) {

  validate_string($password)

  ::openstacklib::db::mysql { 'oslo':
    user          => $user,
    password_hash => mysql_password($password),
    dbname        => $dbname,
    host          => $host,
    charset       => $charset,
    collate       => $collate,
    allowed_hosts => $allowed_hosts,
  }

  ::Openstacklib::Db::Mysql['oslo'] ~> Exec<| title == 'oslo-manage db_sync' |>
}
