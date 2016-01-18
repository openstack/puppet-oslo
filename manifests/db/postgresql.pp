# == Class: oslo::db::postgresql
#
# Class that configures postgresql for oslo
# Requires the Puppetlabs postgresql module.
#
# === Parameters
#
# [*password*]
#   (Required) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'oslo'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'oslo'.
#
#  [*encoding*]
#    (Optional) The charset to use for the database.
#    Default to undef.
#
#  [*privileges*]
#    (Optional) Privileges given to the database user.
#    Default to 'ALL'
#
# == Dependencies
#
# == Examples
#
# == Authors
#
# == Copyright
#
class oslo::db::postgresql(
  $password,
  $dbname     = 'oslo',
  $user       = 'oslo',
  $encoding   = undef,
  $privileges = 'ALL',
) {

  Class['oslo::db::postgresql'] -> Service<| title == 'oslo' |>

  ::openstacklib::db::postgresql { 'oslo':
    password_hash => postgresql_password($user, $password),
    dbname        => $dbname,
    user          => $user,
    encoding      => $encoding,
    privileges    => $privileges,
  }

  ::Openstacklib::Db::Postgresql['oslo'] ~> Exec<| title == 'oslo-manage db_sync' |>

}
