require 'spec_helper'

describe 'oslo::middleware' do

  let (:title) { 'keystone_config' }

  shared_examples 'shared examples' do

    context 'with default parameters' do
      it 'configure oslo_middleware default params' do
       is_expected.to contain_keystone_config('oslo_middleware/max_request_body_size').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_middleware/enable_proxy_headers_parsing').with_value('<SERVICE DEFAULT>')
      end

    end

    context 'with overridden parameters' do
      let :params do
          {
            :max_request_body_size => 114600,
            :enable_proxy_headers_parsing => true,
          }
      end
      it 'configure oslo_middleware with overriden values' do
        is_expected.to contain_keystone_config('oslo_middleware/max_request_body_size').with_value(114600)
        is_expected.to contain_keystone_config('oslo_middleware/enable_proxy_headers_parsing').with_value(true)
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
