require 'spec_helper'

describe 'oslo::versionedobjects' do

  let (:title) { 'keystone_config' }

  shared_examples 'shared examples' do

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

  context 'on a Debian osfamily' do
    let :facts do
      @default_facts.merge({ :osfamily => "Debian" })
    end

    include_examples 'shared examples'
  end

  context 'on a RedHat osfamily' do
    let :facts do
      @default_facts.merge({ :osfamily => 'RedHat' })
    end

    include_examples 'shared examples'
  end
end
