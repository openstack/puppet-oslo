require 'spec_helper'

describe 'oslo::service' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::service' do

    context 'with default parameters' do
      it 'configures service parameters' do
        is_expected.to contain_keystone_config('DEFAULT/backdoor_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/backdoor_socket').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/graceful_shutdown_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/log_options').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('DEFAULT/run_external_periodic_tasks').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :backdoor_port               => '1234',
          :backdoor_socket             => 'backdoor.sock',
          :graceful_shutdown_timeout   => '60',
          :log_options                 => true,
          :run_external_periodic_tasks => true,
        }
      end

      it 'configures service parameters' do
        is_expected.to contain_keystone_config('DEFAULT/backdoor_port').with_value('1234')
        is_expected.to contain_keystone_config('DEFAULT/backdoor_socket').with_value('backdoor.sock')
        is_expected.to contain_keystone_config('DEFAULT/graceful_shutdown_timeout').with_value('60')
        is_expected.to contain_keystone_config('DEFAULT/log_options').with_value(true)
        is_expected.to contain_keystone_config('DEFAULT/run_external_periodic_tasks').with_value(true)
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

     it_behaves_like 'oslo::service'
    end
  end
end
