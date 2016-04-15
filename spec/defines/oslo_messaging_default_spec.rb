require 'spec_helper'

describe 'oslo::messaging::default' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-messaging-default' do

    context 'with default parameters' do
      it 'configure DEFAULT default params' do
        is_expected.to contain_keystone_config('DEFAULT/rpc_response_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/transport_url').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/control_exchange').with_value('<SERVICE DEFAULT>')
      end

    end

    context 'with overridden parameters' do
      let :params do
          {
            :rpc_response_timeout    => '42',
            :transport_url           => 'proto://url',
            :control_exchange        => 'openstack',
          }
      end

      it 'configure DEFAULT with overriden values' do
        is_expected.to contain_keystone_config('DEFAULT/rpc_response_timeout').with_value('42')
        is_expected.to contain_keystone_config('DEFAULT/transport_url').with_value('proto://url')
        is_expected.to contain_keystone_config('DEFAULT/control_exchange').with_value('openstack')
      end
    end
  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'oslo-messaging-default'
    end
  end
end
