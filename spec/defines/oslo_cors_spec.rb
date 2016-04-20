require 'spec_helper'

describe 'oslo::cors' do

  let (:title) { 'keystone_config' }

  shared_examples 'shared examples' do

    context 'with default parameters' do
      it 'configure cors default params' do
       is_expected.to contain_keystone_config('cors/allowed_origin').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('cors/allow_credentials').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('cors/expose_headers').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('cors/max_age').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('cors/allow_methods').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('cors/allow_headers').with_value('<SERVICE DEFAULT>')
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

      include_examples 'shared examples'
    end
  end
end
