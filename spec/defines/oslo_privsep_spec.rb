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
        is_expected.to contain_keystone_config('privsep_osbrick/helper_command').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      before do
        params.merge!({
          :user           => 'keystone',
          :group          => 'keystone',
          :capabilities   => [],
          :helper_command => 'sudo nova-rootwrap /etc/nova/rootwrap.conf privsep-helper --config-file /etc/nova/nova.conf',
        })
      end

      it 'configures oslo_privsep section' do
        is_expected.to contain_keystone_config('privsep_osbrick/user').with_value('keystone')
        is_expected.to contain_keystone_config('privsep_osbrick/group').with_value('keystone')
        is_expected.to contain_keystone_config('privsep_osbrick/capabilities').with_value([])
        is_expected.to contain_keystone_config('privsep_osbrick/helper_command').with_value('sudo nova-rootwrap /etc/nova/rootwrap.conf privsep-helper --config-file /etc/nova/nova.conf')
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
