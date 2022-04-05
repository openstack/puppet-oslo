require 'spec_helper'

describe 'oslo::service::wsgi' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::service::wsgi' do

    context 'with default parameters' do
      it 'configures wsgi parameters' do
        is_expected.to contain_keystone_config('DEFAULT/api_paste_config').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/client_socket_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/max_header_line').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/tcp_keepidle').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_default_pool_size').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_keep_alive').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_log_format').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :api_paste_config       => 'api-paste.ini',
          :client_socket_timeout  => '900',
          :max_header_line        => '16384',
          :tcp_keepidle           => '600',
          :wsgi_default_pool_size => '1000',
          :wsgi_keep_alive        => true,
          :wsgi_log_format        => '%(client_ip)s "%(request_line)s" status: %(status_code)s len: %(body_length)s time: %(wall_seconds).7f',
        }
      end

      it 'configures wsgi parameters' do
        is_expected.to contain_keystone_config('DEFAULT/api_paste_config').with_value('api-paste.ini')
        is_expected.to contain_keystone_config('DEFAULT/client_socket_timeout').with_value('900')
        is_expected.to contain_keystone_config('DEFAULT/max_header_line').with_value('16384')
        is_expected.to contain_keystone_config('DEFAULT/tcp_keepidle').with_value('600')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_default_pool_size').with_value('1000')
        is_expected.to contain_keystone_config('DEFAULT/wsgi_keep_alive').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/wsgi_log_format').with_value(
          '%(client_ip)s "%(request_line)s" status: %(status_code)s len: %(body_length)s time: %(wall_seconds).7f')
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

     it_behaves_like 'oslo::service::wsgi'
    end
  end
end
