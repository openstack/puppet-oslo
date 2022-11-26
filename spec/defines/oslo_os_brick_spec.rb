require 'spec_helper'

describe 'oslo::os_brick' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::os_brick' do

    context 'with defaults' do
      it 'configures the default values' do
        is_expected.to contain_keystone_config('os_brick/lock_path').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with parameters overridden' do
      let :params do
        {
          :lock_path => '/var/lib/openstack/lock'
        }
      end

      it 'configures the overridden values' do
        is_expected.to contain_keystone_config('os_brick/lock_path').with_value('/var/lib/openstack/lock')
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

      include_examples 'oslo::os_brick'
    end
  end
end
