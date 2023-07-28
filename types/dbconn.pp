type Oslo::Dbconn = Variant[
  Oslo::Dbconn::Sqlite,
  Oslo::Dbconn::Mysql,
  Oslo::Dbconn::Postgres,
  Openstacklib::Servicedefault,
]
