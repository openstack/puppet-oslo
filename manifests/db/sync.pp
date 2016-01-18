#
# Class to execute oslo-manage db_sync
#
# == Parameters
#
# [*extra_params*]
#   (optional) String of extra command line parameters to append
#   to the oslo-dbsync command.
#   Defaults to undef
#
class oslo::db::sync(
  $extra_params  = undef,
) {
  exec { 'oslo-db-sync':
    command     => "oslo-manage db_sync ${extra_params}",
    path        => '/usr/bin',
    user        => 'oslo',
    refreshonly => true,
    subscribe   => [Package['oslo'], Oslo_config['database/connection']],
  }

  Exec['oslo-manage db_sync'] ~> Service<| title == 'oslo' |>
}
