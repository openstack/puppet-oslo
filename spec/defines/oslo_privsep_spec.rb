require 'spec_helper'

describe 'oslo::privsep' do

  let (:title) { 'osbrick' }

  let :params do
    { :config => 'keystone_config' }
  end

  shared_examples 'oslo-privsep' do

    context 'with default parameters' do
      it 'configure oslo_privsep default params' do
        is_expected.to contain_keystone_config('privsep_osbrick/user').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('privsep_osbrick/group').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('privsep_osbrick/capabilities').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('privsep_osbrick/thread_pool_size').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('privsep_osbrick/helper_command').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('privsep_osbrick/logger_name').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      before do
        params.merge!({
          :user             => 'keystone',
          :group            => 'keystone',
          :capabilities     => [],
          :thread_pool_size => 1,
          :helper_command   => 'sudo nova-rootwrap /etc/nova/rootwrap.conf privsep-helper --config-file /etc/nova/nova.conf',
          :logger_name      => 'oslo_privsep.daemon',
        })
      end

      it 'configures oslo_privsep section' do
        is_expected.to contain_keystone_config('privsep_osbrick/user').with_value('keystone')
        is_expected.to contain_keystone_config('privsep_osbrick/group').with_value('keystone')
        is_expected.to contain_keystone_config('privsep_osbrick/capabilities').with_value([])
        is_expected.to contain_keystone_config('privsep_osbrick/thread_pool_size').with_value(1)
        is_expected.to contain_keystone_config('privsep_osbrick/helper_command').with_value('sudo nova-rootwrap /etc/nova/rootwrap.conf privsep-helper --config-file /etc/nova/nova.conf')
        is_expected.to contain_keystone_config('privsep_osbrick/logger_name').with_value('oslo_privsep.daemon')
      end
    end

    context 'with config group' do
      before do
        params.merge!({
          :config_group => 'mysection'
        })
      end

      it 'configure oslo_privsep default params' do
        is_expected.to contain_keystone_config('mysection/user').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('mysection/group').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('mysection/capabilities').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('mysection/thread_pool_size').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('mysection/helper_command').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('mysection/logger_name').with_value('<SERVICE DEFAULT>')
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

      it_behaves_like 'oslo-privsep'
    end
  end
end
