require 'spec_helper'

describe 'oslo::reports' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::reports' do

    context 'with default parameters' do
      let :params do
        {}
      end

      it 'configure reports default params' do
        is_expected.to contain_keystone_config('oslo_reports/log_dir').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_reports/file_event_handler').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_reports/file_event_handler_interval').with_value('<SERVICE DEFAULT>')
      end

      it 'should not manage the oslo.reports package' do
        is_expected.to_not contain_package('oslo.reports')
      end
    end

    context 'with parameters overridden' do
      let :params do
        {
          :log_dir                     => '/var/log/keystone',
          :file_event_handler          => '/var/tmp/keystone/reports',
          :file_event_handler_interval => 1,
        }
      end

      it 'configure oslo_reports params' do
        is_expected.to contain_keystone_config('oslo_reports/log_dir').with_value('/var/log/keystone')
        is_expected.to contain_keystone_config('oslo_reports/file_event_handler').with_value('/var/tmp/keystone/reports')
        is_expected.to contain_keystone_config('oslo_reports/file_event_handler_interval').with_value(1)
      end
    end

    context 'with package management enabled' do
      let :params do
        { :manage_package => true }
      end

      it 'should not manage the oslo.reports package' do
        is_expected.to contain_package('oslo.reports').with(
          :ensure => 'installed',
          :name   => platform_params[:oslo_reports_package_name],
          :tag    => ['openstack'],
        )
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

      let(:platform_params) do
        case facts[:os]['family']
        when 'Debian'
          { :oslo_reports_package_name => 'python3-oslo.reports' }
        when 'RedHat'
          { :oslo_reports_package_name => 'python3-oslo-reports' }
        end
      end

      include_examples 'oslo::reports'
    end
  end
end
