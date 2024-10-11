require 'spec_helper'

describe 'oslo::limit' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::limit' do

    let :required_params do
      {
        :username => 'keystone',
        :password => 'keystone_password',
      }
    end

    context 'with endpoint_id' do
      let :params do
        required_params.merge!({
          :endpoint_id => '770f924a-e483-4b43-a6f3-73acc91f4757'
        })
      end

      context 'with default parameters' do
        it 'configures the required params' do
          is_expected.to contain_keystone_config('oslo_limit/username').with_value('keystone')
          is_expected.to contain_keystone_config('oslo_limit/password').with_value('keystone_password').with_secret(true)
          is_expected.to contain_keystone_config('oslo_limit/endpoint_id').with_value('770f924a-e483-4b43-a6f3-73acc91f4757')
          is_expected.to contain_keystone_config('oslo_limit/endpoint_service_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/endpoint_service_name').with_value('<SERVICE DEFAULT>')
        end

        it 'configures the default params' do
          is_expected.to contain_keystone_config('oslo_limit/endpoint_region_name').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/endpoint_interface').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/auth_url').with_value('http://localhost:5000')
          is_expected.to contain_keystone_config('oslo_limit/project_name').with_value('services')
          is_expected.to contain_keystone_config('oslo_limit/user_domain_name').with_value('Default')
          is_expected.to contain_keystone_config('oslo_limit/project_domain_name').with_value('Default')
          is_expected.to contain_keystone_config('oslo_limit/system_scope').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/auth_type').with_value('password')
          is_expected.to contain_keystone_config('oslo_limit/service_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/valid_interfaces').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/region_name').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/endpoint_override').with_value('<SERVICE DEFAULT>')
        end
      end

      context 'with parameters overridden' do
        before :each do
          params.merge!({
            :endpoint_region_name => 'regionOne',
            :endpoint_interface   => 'public',
            :auth_url             => 'http://localhost:5000/v3',
            :project_name         => 'alt_services',
            :user_domain_name     => 'UserDomain',
            :project_domain_name  => 'ProjectDomain',
            :auth_type            => 'v3password',
            :service_type         => 'identity',
            :valid_interfaces     => ['admin', 'internal'],
            :region_name          => 'regionOne',
            :endpoint_override    => 'http://localhost:5000',
          })
        end

        it 'configures the overridden values' do
          is_expected.to contain_keystone_config('oslo_limit/endpoint_region_name').with_value('regionOne')
          is_expected.to contain_keystone_config('oslo_limit/endpoint_interface').with_value('public')
          is_expected.to contain_keystone_config('oslo_limit/auth_url').with_value('http://localhost:5000/v3')
          is_expected.to contain_keystone_config('oslo_limit/project_name').with_value('alt_services')
          is_expected.to contain_keystone_config('oslo_limit/user_domain_name').with_value('UserDomain')
          is_expected.to contain_keystone_config('oslo_limit/project_domain_name').with_value('ProjectDomain')
          is_expected.to contain_keystone_config('oslo_limit/system_scope').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/auth_type').with_value('v3password')
          is_expected.to contain_keystone_config('oslo_limit/service_type').with_value('identity')
          is_expected.to contain_keystone_config('oslo_limit/valid_interfaces').with_value('admin,internal')
          is_expected.to contain_keystone_config('oslo_limit/region_name').with_value('regionOne')
          is_expected.to contain_keystone_config('oslo_limit/endpoint_override').with_value('http://localhost:5000')
        end
      end

      context 'with system_scope' do
        before :each do
          params.merge!({
            :project_name => 'services',
            :system_scope => 'all',
          })
        end

        it 'configures system_scope but ignore project parameters' do
          is_expected.to contain_keystone_config('oslo_limit/project_name').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/project_domain_name').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_keystone_config('oslo_limit/system_scope').with_value('all')
        end
      end
    end

    context 'with endpoint_service_name' do
      let :params do
        required_params.merge({
          :endpoint_service_name => 'nova',
        })
      end

      it 'configures the required params' do
        is_expected.to contain_keystone_config('oslo_limit/username').with_value('keystone')
        is_expected.to contain_keystone_config('oslo_limit/password').with_value('keystone_password').with_secret(true)
        is_expected.to contain_keystone_config('oslo_limit/endpoint_id').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_limit/endpoint_service_type').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_limit/endpoint_service_name').with_value('nova')
      end
    end

    context 'with endpoint_service_type' do
      let :params do
        required_params.merge({
          :endpoint_service_type => 'compute',
        })
      end

      it 'configures the required params' do
        is_expected.to contain_keystone_config('oslo_limit/username').with_value('keystone')
        is_expected.to contain_keystone_config('oslo_limit/password').with_value('keystone_password').with_secret(true)
        is_expected.to contain_keystone_config('oslo_limit/endpoint_id').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_limit/endpoint_service_type').with_value('compute')
        is_expected.to contain_keystone_config('oslo_limit/endpoint_service_name').with_value('<SERVICE DEFAULT>')
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

      include_examples 'oslo::limit'
    end
  end
end
