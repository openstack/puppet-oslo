require 'spec_helper'

describe 'oslo::concurrency' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-concurrency' do

    context 'with default parameters' do
      it 'configures oslo_concurrency default params' do
        is_expected.to contain_keystone_config('oslo_concurrency/disable_process_locking').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_concurrency/lock_path').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :disable_process_locking => 'true',
          :lock_path               => '/lock/dir/',
        }
      end

      it 'configures oslo_concurrency section' do
        is_expected.to contain_keystone_config('oslo_concurrency/disable_process_locking').with_value('true')
        is_expected.to contain_keystone_config('oslo_concurrency/lock_path').with_value('/lock/dir/')
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

      it_behaves_like 'oslo-concurrency'
    end
  end
end
