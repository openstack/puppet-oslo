require 'spec_helper'

describe 'oslo::key_manager' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::key_manager' do

    context 'with default parameters' do
      let :params do
        {}
      end

      it 'configure key_manager default params' do
        is_expected.to contain_keystone_config('key_manager/backend').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with parameters overridden' do
      let :params do
        {
          :backend => 'barbican'
        }
      end

      it 'configure key_manager params' do
        is_expected.to contain_keystone_config('key_manager/backend').with_value('barbican')
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

      include_examples 'oslo::key_manager'
    end
  end
end
