require 'spec_helper'

describe 'oslo::service::ssl' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::service::ssl' do

    context 'with default parameters' do
      it 'configures ssl parameters' do
        is_expected.to contain_keystone_config('ssl/ca_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/cert_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/ciphers').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/key_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('ssl/version').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :ca_file   => '/path/to/ca/file',
          :cert_file => '/path/to/cert/file',
          :ciphers   => 'HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM',
          :key_file  => '/path/to/key/file',
          :version   => 'TLSv1',
        }
      end

      it 'configures ssl parameters' do
        is_expected.to contain_keystone_config('ssl/ca_file').with_value('/path/to/ca/file')
        is_expected.to contain_keystone_config('ssl/cert_file').with_value('/path/to/cert/file')
        is_expected.to contain_keystone_config('ssl/ciphers').with_value('HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM')
        is_expected.to contain_keystone_config('ssl/key_file').with_value('/path/to/key/file')
        is_expected.to contain_keystone_config('ssl/version').with_value('TLSv1')
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

     it_behaves_like 'oslo::service::ssl'
    end
  end
end
