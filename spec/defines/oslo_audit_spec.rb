require 'spec_helper'

describe 'oslo::audit' do

  let (:title) { 'keystone_config' }

  shared_examples_for 'oslo::audit' do

    context 'with default parameters' do
      let :params do
        {}
      end

      it 'configures default values' do
        is_expected.to contain_keystone_config('audit/audit_map_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('audit/ignore_req_list').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with specific parameters' do
      let :params do
        {
          :audit_map_file  => '/etc/ironic/api_audit_map.conf',
          :ignore_req_list => 'GET,POST',
        }
      end

      it 'configures specified values' do
        is_expected.to contain_keystone_config('audit/audit_map_file').with_value('/etc/ironic/api_audit_map.conf')
        is_expected.to contain_keystone_config('audit/ignore_req_list').with_value('GET,POST')
      end
    end

    context 'with ignore_req_list in array' do
      let :params do
        {
          :ignore_req_list => ['GET', 'POST'],
        }
      end

      it 'configures ignore_req_list with a comma separated list' do
        is_expected.to contain_keystone_config('audit/ignore_req_list').with_value('GET,POST')
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

      it_configures 'oslo::audit'
    end
  end

end
