#
# Unit tests for oslo::keystone::auth
#

require 'spec_helper'

describe 'oslo::keystone::auth' do

  let :facts do
    { :osfamily => 'Debian' }
  end

  describe 'with default class parameters' do
    let :params do
      { :password => 'oslo_password',
        :tenant   => 'foobar' }
    end

    it { is_expected.to contain_keystone_user('oslo').with(
      :ensure   => 'present',
      :password => 'oslo_password',
    ) }

    it { is_expected.to contain_keystone_user_role('oslo@foobar').with(
      :ensure  => 'present',
      :roles   => ['admin']
    )}

    it { is_expected.to contain_keystone_service('oslo::FIXME').with(
      :ensure      => 'present',
      :description => 'oslo FIXME Service'
    ) }

    it { is_expected.to contain_keystone_endpoint('RegionOne/oslo::FIXME').with(
      :ensure       => 'present',
      :public_url   => 'http://127.0.0.1:FIXME',
      :admin_url    => 'http://127.0.0.1:FIXME',
      :internal_url => 'http://127.0.0.1:FIXME',
    ) }
  end

  describe 'when overriding URL parameters' do
    let :params do
      { :password     => 'oslo_password',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81', }
    end

    it { is_expected.to contain_keystone_endpoint('RegionOne/oslo::FIXME').with(
      :ensure       => 'present',
      :public_url   => 'https://10.10.10.10:80',
      :internal_url => 'http://10.10.10.11:81',
      :admin_url    => 'http://10.10.10.12:81',
    ) }
  end

  describe 'when overriding auth name' do
    let :params do
      { :password => 'foo',
        :auth_name => 'osloy' }
    end

    it { is_expected.to contain_keystone_user('osloy') }
    it { is_expected.to contain_keystone_user_role('osloy@services') }
    it { is_expected.to contain_keystone_service('osloy::FIXME') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/osloy::FIXME') }
  end

  describe 'when overriding service name' do
    let :params do
      { :service_name => 'oslo_service',
        :auth_name    => 'oslo',
        :password     => 'oslo_password' }
    end

    it { is_expected.to contain_keystone_user('oslo') }
    it { is_expected.to contain_keystone_user_role('oslo@services') }
    it { is_expected.to contain_keystone_service('oslo_service::FIXME') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/oslo_service::FIXME') }
  end

  describe 'when disabling user configuration' do

    let :params do
      {
        :password       => 'oslo_password',
        :configure_user => false
      }
    end

    it { is_expected.not_to contain_keystone_user('oslo') }
    it { is_expected.to contain_keystone_user_role('oslo@services') }
    it { is_expected.to contain_keystone_service('oslo::FIXME').with(
      :ensure      => 'present',
      :description => 'oslo FIXME Service'
    ) }

  end

  describe 'when disabling user and user role configuration' do

    let :params do
      {
        :password            => 'oslo_password',
        :configure_user      => false,
        :configure_user_role => false
      }
    end

    it { is_expected.not_to contain_keystone_user('oslo') }
    it { is_expected.not_to contain_keystone_user_role('oslo@services') }
    it { is_expected.to contain_keystone_service('oslo::FIXME').with(
      :ensure      => 'present',
      :description => 'oslo FIXME Service'
    ) }

  end

end
