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

    context 'with parameters' do
      let (:params) do
        {
          :allowed_origin    => 'https://horizon.example.com,https://horizon.example2.com',
          :allow_credentials => true,
          :expose_headers    => 'HeaderOne,HeaderTwo',
          :max_age           => 3600,
          :allow_methods     => 'GET,HEAD',
          :allow_headers     => 'HeaderThree,HeaderFour',
        }
      end

      it 'configure cors params' do
       is_expected.to contain_keystone_config('cors/allowed_origin').with_value('https://horizon.example.com,https://horizon.example2.com')
       is_expected.to contain_keystone_config('cors/allow_credentials').with_value(true)
       is_expected.to contain_keystone_config('cors/expose_headers').with_value('HeaderOne,HeaderTwo')
       is_expected.to contain_keystone_config('cors/max_age').with_value(3600)
       is_expected.to contain_keystone_config('cors/allow_methods').with_value('GET,HEAD')
       is_expected.to contain_keystone_config('cors/allow_headers').with_value('HeaderThree,HeaderFour')
      end
    end

    context 'with parameters in array' do
      let (:params) do
        {
          :allowed_origin    => ['https://horizon.example.com', 'https://horizon.example2.com'],
          :expose_headers    => ['HeaderOne', 'HeaderTwo'],
          :allow_methods     => ['GET', 'HEAD'],
          :allow_headers     => ['HeaderThree', 'HeaderFour'],
        }
      end

      it 'configure cors params' do
       is_expected.to contain_keystone_config('cors/allowed_origin').with_value('https://horizon.example.com,https://horizon.example2.com')
       is_expected.to contain_keystone_config('cors/expose_headers').with_value('HeaderOne,HeaderTwo')
       is_expected.to contain_keystone_config('cors/allow_methods').with_value('GET,HEAD')
       is_expected.to contain_keystone_config('cors/allow_headers').with_value('HeaderThree,HeaderFour')
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
