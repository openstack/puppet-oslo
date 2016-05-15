require 'spec_helper'

describe 'oslo::log' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-log' do

    context 'with default parameters' do
      it 'configure oslo_log default params' do
        is_expected.to contain_keystone_config('DEFAULT/debug').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/log_config_append').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/log_date_format').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/log_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/log_dir').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/watch_log_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/use_syslog').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/syslog_log_facility').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/use_stderr').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/logging_context_format_string').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/logging_default_format_string').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/logging_debug_format_suffix').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/logging_exception_prefix').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/logging_user_identity_format').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/default_log_levels').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/publish_errors').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/instance_format').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/instance_uuid_format').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/fatal_deprecations').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        { :debug                         => true,
          :log_config_append             => '/var/log/keystone/keystone.log',
          :log_date_format               => '%Y-%m-%d %H:%M:%S',
          :log_file                      => '/var/log/keystone/keystone.log',
          :log_dir                       => '/var/log/keystone',
          :watch_log_file                => true,
          :use_syslog                    => true,
          :syslog_log_facility           => 'LOG_USER',
          :use_stderr                    => true,
          :logging_context_format_string =>
            '%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s [%(request_id)s %(user_identity)s] %(instance)s%(message)s',
          :logging_default_format_string => '%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s [-] %(instance)s%(message)s',
          :logging_debug_format_suffix   => '%(funcName)s %(pathname)s:%(lineno)d',
          :logging_exception_prefix      => '%(asctime)s.%(msecs)03d %(process)d ERROR %(name)s %(instance)s',
          :logging_user_identity_format  => '%(user)s %(tenant)s %(domain)s %(user_domain)s %(project_domain)s',
          :default_log_levels            => {
            'amqp' => 'WARN', 'amqplib' => 'WARN', 'boto' => 'WARN', 'sqlalchemy' => 'WARN',
            'suds' => 'INFO', 'iso8601' => 'WARN', 'requests.packages.urllib3.connectionpool' => 'WARN' },
          :publish_errors                => true,
          :instance_format               => '[instance: %(uuid)s]',
          :instance_uuid_format          => '[instance: %(uuid)s]',
          :fatal_deprecations            => true,
        }
      end

      it 'configures logging' do
        is_expected.to contain_keystone_config('DEFAULT/debug').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/log_config_append').with_value('/var/log/keystone/keystone.log')
        is_expected.to contain_keystone_config('DEFAULT/log_date_format').with_value('%Y-%m-%d %H:%M:%S')
        is_expected.to contain_keystone_config('DEFAULT/log_file').with_value('/var/log/keystone/keystone.log')
        is_expected.to contain_keystone_config('DEFAULT/log_dir').with_value('/var/log/keystone')
        is_expected.to contain_keystone_config('DEFAULT/watch_log_file').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/use_syslog').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/syslog_log_facility').with_value('LOG_USER')
        is_expected.to contain_keystone_config('DEFAULT/use_stderr').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/logging_context_format_string').with_value(
          '%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s [%(request_id)s %(user_identity)s] %(instance)s%(message)s')
        is_expected.to contain_keystone_config('DEFAULT/logging_default_format_string').with_value(
          '%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s [-] %(instance)s%(message)s')
        is_expected.to contain_keystone_config('DEFAULT/logging_debug_format_suffix').with_value('%(funcName)s %(pathname)s:%(lineno)d')
        is_expected.to contain_keystone_config('DEFAULT/logging_exception_prefix').with_value(
          '%(asctime)s.%(msecs)03d %(process)d ERROR %(name)s %(instance)s')
        is_expected.to contain_keystone_config('DEFAULT/logging_user_identity_format').with_value(
'%(user)s %(tenant)s %(domain)s %(user_domain)s %(project_domain)s')
        is_expected.to contain_keystone_config('DEFAULT/default_log_levels').with_value(
          'amqp=WARN,amqplib=WARN,boto=WARN,iso8601=WARN,requests.packages.urllib3.connectionpool=WARN,sqlalchemy=WARN,suds=INFO')
        is_expected.to contain_keystone_config('DEFAULT/publish_errors').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/instance_format').with_value('[instance: %(uuid)s]')
        is_expected.to contain_keystone_config('DEFAULT/instance_uuid_format').with_value('[instance: %(uuid)s]')
        is_expected.to contain_keystone_config('DEFAULT/fatal_deprecations').with_value(true)
      end
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

     it_behaves_like 'oslo-log'
    end
  end
end
