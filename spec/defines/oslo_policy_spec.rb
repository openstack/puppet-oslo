require 'spec_helper'

describe 'oslo::policy' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-policy' do

    context 'with default parameters' do
      it 'configure oslo_policy default params' do
        is_expected.to contain_keystone_config('oslo_policy/policy_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_policy/policy_default_rule').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_policy/policy_dirs').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :policy_file         => '/path/to/policy.file',
          :policy_default_rule => 'some rule',
          :policy_dirs         => ['dir1', '/dir/2'],
        }
      end

      it 'configures oslo_policy section' do
        is_expected.to contain_keystone_config('oslo_policy/policy_file').with_value('/path/to/policy.file')
        is_expected.to contain_keystone_config('oslo_policy/policy_default_rule').with_value('some rule')
        is_expected.to contain_keystone_config('oslo_policy/policy_dirs').with_value('dir1,/dir/2')
      end
    end

    context 'with string in list parameters' do
      let :params do
        {
          :policy_dirs => 'dir1,/dir/2',
        }
      end

      it 'configures oslo_policy section with overriden list values as strings' do
        is_expected.to contain_keystone_config('oslo_policy/policy_dirs').with_value('dir1,/dir/2')
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

      it_behaves_like 'oslo-policy'
    end
  end
end
