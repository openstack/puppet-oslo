require 'spec_helper'

describe 'oslo::versionedobjects' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-versionedobjects' do

    context 'with default parameters' do
      it 'configure oslo_versionedobjects default params' do
       is_expected.to contain_keystone_config('oslo_versionedobjects/fatal_exception_format_errors').with_value('<SERVICE DEFAULT>')
      end

    end

    context 'with overridden parameters' do
      let :params do
          { :fatal_exception_format_errors => true,
          }
      end
      it 'configure oslo_versionedobjects with overriden values' do
        is_expected.to contain_keystone_config('oslo_versionedobjects/fatal_exception_format_errors').with_value(true)
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

     it_behaves_like 'oslo-versionedobjects'
    end
  end

end
