require 'spec_helper'

describe 'oslo::db' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-db' do

    context 'with default parameters' do
      it 'configure oslo_db default params' do
        is_expected.to contain_keystone_config('database/sqlite_synchronous').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/backend').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/connection').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/slave_connection').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/mysql_sql_mode').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/connection_recycle_time').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/max_pool_size').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/max_retries').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/retry_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/max_overflow').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/connection_debug').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/connection_trace').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/pool_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/use_db_reconnect').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/db_retry_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/db_inc_retry_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/db_max_retry_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/db_max_retries').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('database/mysql_enable_ndb').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :config_group            => 'custom_group',
          :backend                 => 'sqlalchemy',
          :connection              => 'mysql+pymysql://db:db@localhost/db',
          :mysql_sql_mode          => 'TRADITIONAL',
          :connection_recycle_time => '3601',
          :max_pool_size           => '100',
          :max_retries             => '10',
          :retry_interval          => '10',
          :max_overflow            => '50',
          :connection_debug        => '0',
          :connection_trace        => true,
          :pool_timeout            => '10',
          :use_db_reconnect        => true,
          :db_retry_interval       => '1',
          :db_inc_retry_interval   => true,
          :db_max_retry_interval   => '10',
          :db_max_retries          => '20',
          :mysql_enable_ndb        => true,
        }
      end

      it 'configures database parameters' do
        is_expected.to contain_keystone_config('custom_group/backend').with_value('sqlalchemy')
        is_expected.to contain_keystone_config('custom_group/connection').with_value('mysql+pymysql://db:db@localhost/db').with_secret(true)
        is_expected.to contain_keystone_config('custom_group/mysql_sql_mode').with_value('TRADITIONAL')
        is_expected.to contain_keystone_config('custom_group/connection_recycle_time').with_value('3601')
        is_expected.to contain_keystone_config('custom_group/max_pool_size').with_value('100')
        is_expected.to contain_keystone_config('custom_group/max_retries').with_value('10')
        is_expected.to contain_keystone_config('custom_group/retry_interval').with_value('10')
        is_expected.to contain_keystone_config('custom_group/max_overflow').with_value('50')
        is_expected.to contain_keystone_config('custom_group/connection_debug').with_value('0')
        is_expected.to contain_keystone_config('custom_group/connection_trace').with_value(true)
        is_expected.to contain_keystone_config('custom_group/pool_timeout').with_value('10')
        is_expected.to contain_keystone_config('custom_group/use_db_reconnect').with_value(true)
        is_expected.to contain_keystone_config('custom_group/db_retry_interval').with_value('1')
        is_expected.to contain_keystone_config('custom_group/db_inc_retry_interval').with_value(true)
        is_expected.to contain_keystone_config('custom_group/db_max_retry_interval').with_value('10')
        is_expected.to contain_keystone_config('custom_group/db_max_retries').with_value('20')
        is_expected.to contain_keystone_config('custom_group/mysql_enable_ndb').with_value(true)
      end
    end

    context 'with config management disabled' do
      let :params do
        { :manage_config => false }
      end

      it 'does not manage config options' do
        is_expected.to_not contain_keystone_config('custom_group/backend')
        is_expected.to_not contain_keystone_config('custom_group/conection')
      end
    end

    context 'with pymysql connection' do
      let :params do
        { :connection => 'mysql+pymysql://db:db@localhost/db' }
      end

      it { is_expected.to contain_class('oslo::params') }
      it { is_expected.to contain_keystone_config('database/connection').with_value('mysql+pymysql://db:db@localhost/db').with_secret(true) }
    end

    context 'with postgresql backend' do
      let :params do
        { :connection => 'postgresql://db:db@localhost/db', }
      end

      it { is_expected.to contain_keystone_config('database/connection').with_value('postgresql://db:db@localhost/db').with_secret(true) }
      it { is_expected.to contain_class('postgresql::lib::python') }

      context 'with backend package management disabled' do
        before do
          params.merge!({
            :manage_backend_package => false,
          })
        end

        it 'does not install backend package' do
          is_expected.not_to contain_class('postgresql::lib::python')
        end
      end
    end

    context 'with postgresql backend + drivername' do
      let :params do
        { :connection => 'postgresql+psycopg2://db:db@localhost/db' }
      end

      it { is_expected.to contain_keystone_config('database/connection').with_value('postgresql+psycopg2://db:db@localhost/db').with_secret(true) }
      it { is_expected.to contain_class('postgresql::lib::python') }
    end

    context 'with incorrect database_connection string' do
      let :params do
        { :connection => 'foo://db:db@localhost/db', }
      end

      it { should raise_error(Puppet::Error) }
    end

    context 'with incorrect pymysql database_connection string' do
      let :params do
        { :connection => 'foo+pymysql://db:db@localhost/db', }
      end

      it { should raise_error(Puppet::Error) }
    end
  end

  shared_examples 'oslo-db on Debian' do
   context 'using pymysql driver' do
      let :params do
        { :connection => 'mysql+pymysql:///db:db@localhost/db', }
      end

      it 'install the proper backend package' do
        is_expected.to contain_package(platform_params[:pymysql_package_name]).with(
          :ensure => 'present',
          :name   => platform_params[:pymysql_package_name],
          :tag    => 'openstack'
        )
      end

      context 'with backend package management disabled' do
        before do
          params.merge!({
            :manage_backend_package => false,
          })
        end

        it 'does not install backend package' do
          is_expected.not_to contain_package('python-pymysql')
        end
      end
    end

    context 'with sqlite backend' do
      let :params do
        { :connection => 'sqlite:///var/lib/db.db', }
      end

      it 'install the proper backend package' do
        is_expected.to contain_package(platform_params[:pysqlite2_package_name]).with(
          :ensure => 'present',
          :name   => platform_params[:pysqlite2_package_name],
          :tag    => 'openstack'
        )
      end

      context 'with backend package management disabled' do
        before do
          params.merge!({
            :manage_backend_package => false,
          })
        end

        it 'does not install backend package' do
          is_expected.not_to contain_package('python-pysqlite2')
        end
      end
    end
  end

  shared_examples 'oslo-db on RedHat' do
    context 'using pymysql driver' do
      let :params do
        { :connection => 'mysql+pymysql:///db:db@localhost/db', }
      end
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts({
          # puppet-postgresql requires the service_provider fact provided by
          # puppetlabs-postgresql.
          :service_provider => 'systemd'
        }))
      end

      let (:platform_params) do
        case facts[:os]['family']
        when 'Debian'
          {
            :pymongo_package_name   => 'python3-pymongo',
            :pymysql_package_name   => 'python3-pymysql',
            :pysqlite2_package_name => 'python3-pysqlite2',
          }
        when 'RedHat'
          {
            :pymongo_package_name   => 'python3-pymongo',
            :pymysql_package_name   => nil,
            :pysqlite2_package_name => nil,
          }
        end
      end

      it_behaves_like 'oslo-db'
      it_behaves_like "oslo-db on #{facts[:os]['family']}"
    end
  end
end
