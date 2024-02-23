require 'spec_helper'

describe 'oslo::healthcheck' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::healthcheck' do

    context 'with default parameters' do
      let :params do
        {}
      end

      it 'configure healthcheck default params' do
        is_expected.to contain_keystone_config('healthcheck/detailed').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('healthcheck/backends').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('healthcheck/allowed_source_ranges').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('healthcheck/ignore_proxied_requests').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('healthcheck/disable_by_file_path').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('healthcheck/disable_by_file_paths').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with parameters overridden' do
      let :params do
        {
          :detailed                => true,
          :backends                => ['disable_by_file', 'disable_by_files_ports'],
          :allowed_source_ranges   => ['10.0.0.0/24', '10.0.1.0/24'],
          :disable_by_file_path    => '/etc/keystone/healthcheck/disabled',
          :disable_by_file_paths   => [
            '5000:/etc/keystone/healthcheck/public-disabled',
            '35357:/etc/keystone/healthcheck/admin-disabled'
          ],
          :ignore_proxied_requests => false,
        }
      end

      it 'configure healthcheck params' do
        is_expected.to contain_keystone_config('healthcheck/detailed').with_value('true')
        is_expected.to contain_keystone_config('healthcheck/backends').with_value(
          'disable_by_file,disable_by_files_ports'
        )
        is_expected.to contain_keystone_config('healthcheck/allowed_source_ranges').with_value(
          '10.0.0.0/24,10.0.1.0/24'
        )
        is_expected.to contain_keystone_config('healthcheck/ignore_proxied_requests').with_value('false')
        is_expected.to contain_keystone_config('healthcheck/disable_by_file_path').with_value(
          '/etc/keystone/healthcheck/disabled'
        )
        is_expected.to contain_keystone_config('healthcheck/disable_by_file_paths').with_value(
          '5000:/etc/keystone/healthcheck/public-disabled,35357:/etc/keystone/healthcheck/admin-disabled'
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

      include_examples 'oslo::healthcheck'
    end
  end
end
