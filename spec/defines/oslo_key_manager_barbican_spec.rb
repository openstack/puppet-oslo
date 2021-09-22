require 'spec_helper'

describe 'oslo::key_manager::barbican' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::key_manager::barbican' do

    context 'with default parameters' do
      let :params do
        {}
      end

      it 'configure key_manager default params' do
        is_expected.to contain_keystone_config('barbican/barbican_endpoint').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('barbican/barbican_api_version').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('barbican/auth_endpoint').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('barbican/retry_delay').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('barbican/number_of_retries').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('barbican/barbican_endpoint_type').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('barbican/barbican_region_name').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('barbican/send_service_user_token').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with parameters overridden' do
      let :params do
        {
          :barbican_endpoint       => 'http://localhost:9311/',
          :barbican_api_version    => 'v1',
          :auth_endpoint           => 'http://localhost:5000',
          :retry_delay             => 1,
          :number_of_retries       => 60,
          :barbican_endpoint_type  => 'public',
          :barbican_region_name    => 'regionOne',
          :send_service_user_token => true,
        }
      end

      it 'configure key_manager params' do
        is_expected.to contain_keystone_config('barbican/barbican_endpoint').with_value('http://localhost:9311/')
        is_expected.to contain_keystone_config('barbican/barbican_api_version').with_value('v1')
        is_expected.to contain_keystone_config('barbican/auth_endpoint').with_value('http://localhost:5000')
        is_expected.to contain_keystone_config('barbican/retry_delay').with_value(1)
        is_expected.to contain_keystone_config('barbican/number_of_retries').with_value(60)
        is_expected.to contain_keystone_config('barbican/barbican_endpoint_type').with_value('public')
        is_expected.to contain_keystone_config('barbican/barbican_region_name').with_value('regionOne')
        is_expected.to contain_keystone_config('barbican/send_service_user_token').with_value(true)
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

      include_examples 'oslo::key_manager::barbican'
    end
  end
end
