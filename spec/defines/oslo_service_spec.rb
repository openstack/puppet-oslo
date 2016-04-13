require 'spec_helper'

describe 'oslo::service' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-service' do

    context 'with default parameters' do
      it 'configure oslo_service with default params' do
        is_expected.to contain_keystone_config('DEFAULT/api_paste_config').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/backdoor_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/backdoor_socket').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/client_socket_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/graceful_shutdown_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/log_options').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/max_header_line').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/run_external_periodic_tasks').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/tcp_keepidle').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_default_pool_size').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_keep_alive').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_log_format').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/ca_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/cert_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/ciphers').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/key_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/version').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :api_paste_config            => 'api-paste.ini',
          :backdoor_port               => '1234',
          :backdoor_socket             => 'backdoor.sock',
          :client_socket_timeout       => '900',
          :graceful_shutdown_timeout   => '60',
          :log_options                 => true,
          :max_header_line             => '16384',
          :run_external_periodic_tasks => true,
          :tcp_keepidle                => '600',
          :wsgi_default_pool_size      => '1000',
          :wsgi_keep_alive             => true,
          :wsgi_log_format             => '%(client_ip)s "%(request_line)s" status: %(status_code)s len: %(body_length)s time: %(wall_seconds).7f',
          :ca_file                     => '/path/to/ca/file',
          :cert_file                   => '/path/to/cert/file',
          :ciphers                     => 'HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM',
          :key_file                    => '/path/to/key/file',
          :version                     => 'TLSv1',
        }
      end

      it 'configures default and ssl sections' do
        is_expected.to contain_keystone_config('DEFAULT/api_paste_config').with_value('api-paste.ini')
        is_expected.to contain_keystone_config('DEFAULT/backdoor_port').with_value('1234')
        is_expected.to contain_keystone_config('DEFAULT/backdoor_socket').with_value('backdoor.sock')
        is_expected.to contain_keystone_config('DEFAULT/client_socket_timeout').with_value('900')
        is_expected.to contain_keystone_config('DEFAULT/graceful_shutdown_timeout').with_value('60')
        is_expected.to contain_keystone_config('DEFAULT/log_options').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/max_header_line').with_value('16384')
        is_expected.to contain_keystone_config('DEFAULT/run_external_periodic_tasks').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/tcp_keepidle').with_value('600')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_default_pool_size').with_value('1000')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_keep_alive').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/wsgi_log_format').with_value(
          '%(client_ip)s "%(request_line)s" status: %(status_code)s len: %(body_length)s time: %(wall_seconds).7f')
        is_expected.to contain_keystone_config('ssl/ca_file').with_value('/path/to/ca/file')
        is_expected.to contain_keystone_config('ssl/cert_file').with_value('/path/to/cert/file')
        is_expected.to contain_keystone_config('ssl/ciphers').with_value('HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM')
        is_expected.to contain_keystone_config('ssl/key_file').with_value('/path/to/key/file')
        is_expected.to contain_keystone_config('ssl/version').with_value('TLSv1')
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

     it_behaves_like 'oslo-service'
    end
  end
end
