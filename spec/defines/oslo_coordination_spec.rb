require 'spec_helper'

describe 'oslo::coordination' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo::coordination' do

    context 'with default parameters' do
      it 'configures oslo_cache default params' do
        is_expected.to contain_keystone_config('coordination/backend_url').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with redis backend' do
      let :params do
        { :backend_url => 'redis://localhost:6379' }
      end

      it 'configures redis backend' do
        is_expected.to contain_keystone_config('coordination/backend_url').with_value('redis://localhost:6379')

        is_expected.to contain_package('python-redis').with(
          :name   => platform_params[:python_redis_package_name],
          :ensure => 'present',
          :tag    => 'openstack',
        )
      end
    end

    context 'with etcd3 backend' do
      let :params do
        { :backend_url => 'etcd3://localhost:2379' }
      end

      it 'configures etcd3gw backend' do
        is_expected.to contain_keystone_config('coordination/backend_url').with_value('etcd3://localhost:2379')

        if platform_params[:python_etcd3_package_name]
          is_expected.to contain_package('python-etcd3').with(
            :name   => platform_params[:python_etcd3_package_name],
            :ensure => 'present',
            :tag    => 'openstack',
          )
        else
          is_expected.to_not contain_package('python-etcd3')
        end
      end
    end

    context 'with etcd3gw backend(http)' do
      let :params do
        { :backend_url => 'etcd3+http://localhost:2379' }
      end

      it 'configures etcd3gw backend' do
        is_expected.to contain_keystone_config('coordination/backend_url').with_value('etcd3+http://localhost:2379')
        is_expected.to contain_package('python-etcd3gw')
      end
    end

    context 'with etcd3gw backend(https)' do
      let :params do
        { :backend_url => 'etcd3+https://localhost:2379' }
      end

      it 'configures etcd3gw backend' do
        is_expected.to contain_keystone_config('coordination/backend_url').with_value('etcd3+https://localhost:2379')
        is_expected.to contain_package('python-etcd3gw')
      end
    end

    context 'with memcache backend' do
      let :params do
        { :backend_url => 'memcached://localhost:11211' }
      end

      it 'configures memcache backend' do
        is_expected.to contain_keystone_config('coordination/backend_url').with_value('memcached://localhost:11211')

        is_expected.to contain_package('python-pymemcache').with(
          :name   => platform_params[:python_pymemcache_package_name],
          :ensure => 'present',
          :tag    => 'openstack',
        )
      end
    end

    context 'with configuration management disabled' do
      let :params do
        { :backend_url   => 'redis://localhost:6379',
          :manage_config => false }
      end

      it 'manages only packages' do
        is_expected.to_not contain_keystone_config('coordination/backend_url')

        is_expected.to contain_package('python-redis').with(
          :name   => platform_params[:python_redis_package_name],
          :ensure => 'present',
          :tag    => 'openstack',
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
        case facts[:osfamily]
        when 'Debian'
          { :python_redis_package_name      => 'python3-redis',
            :python_etcd3_package_name      => 'python3-etcd3',
            :python_etcd3gw_package_name    => 'python3-etcd3gw',
            :python_pymemcache_package_name => 'python3-pymemcache' }
        when 'RedHat'
          if facts[:operatingsystem] == 'Fedora'
            { :python_redis_package_name      => 'python3-redis',
              :python_etcd3gw_package_name    => 'python3-etcd3gw',
              :python_pymemcache_package_name => 'python3-pymemcache' }
          else
            if facts[:operatingsystemmajrelease] > '7'
              { :python_redis_package_name      => 'python3-redis',
                :python_etcd3gw_package_name    => 'python3-etcd3gw',
                :python_pymemcache_package_name => 'python3-pymemcache' }
            else
              { :python_redis_package_name      => 'python-redis',
                :python_etcd3gw_package_name    => 'python-etcd3gw',
                :python_pymemcache_package_name => 'python-pymemcache' }
            end
          end
        end
      end

      it_behaves_like 'oslo::coordination'
    end
  end
end
