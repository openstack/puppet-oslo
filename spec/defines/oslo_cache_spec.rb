require 'spec_helper'

describe 'oslo::cache' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-cache' do

    context 'with default parameters' do
      it 'configure oslo_cache default params' do
        is_expected.to contain_keystone_config('cache/config_prefix').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/expiration_time').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/backend').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/backend_argument').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/proxies').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/enabled').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/debug_cache_backend').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_servers').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_dead_retry').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_socket_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_pool_maxsize').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_pool_unused_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_pool_connection_get_timeout').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :config_prefix                        => 'cache.oslo',
          :expiration_time                      => '600',
          :backend                              => 'dogpile.cache.null',
          :backend_argument                     => ['foo:bar'],
          :proxies                              => ['proxy1', 'proxy2'],
          :enabled                              => true,
          :debug_cache_backend                  => true,
          :memcache_servers                     => ['host1:11211', 'host2:11211'],
          :memcache_dead_retry                  => '300',
          :memcache_socket_timeout              => '3',
          :memcache_pool_maxsize                => '10',
          :memcache_pool_unused_timeout         => '60',
          :memcache_pool_connection_get_timeout => '10',
        }
      end

      it 'configures cache section' do
        is_expected.to contain_keystone_config('cache/config_prefix').with_value('cache.oslo')
        is_expected.to contain_keystone_config('cache/expiration_time').with_value('600')
        is_expected.to contain_keystone_config('cache/backend').with_value('dogpile.cache.null')
        is_expected.to contain_keystone_config('cache/backend_argument').with_value('foo:bar')
        is_expected.to contain_keystone_config('cache/proxies').with_value('proxy1,proxy2')
        is_expected.to contain_keystone_config('cache/enabled').with_value('true')
        is_expected.to contain_keystone_config('cache/debug_cache_backend').with_value('true')
        is_expected.to contain_keystone_config('cache/memcache_servers').with_value('host1:11211,host2:11211')
        is_expected.to contain_keystone_config('cache/memcache_dead_retry').with_value('300')
        is_expected.to contain_keystone_config('cache/memcache_socket_timeout').with_value('3')
        is_expected.to contain_keystone_config('cache/memcache_pool_maxsize').with_value('10')
        is_expected.to contain_keystone_config('cache/memcache_pool_unused_timeout').with_value('60')
        is_expected.to contain_keystone_config('cache/memcache_pool_connection_get_timeout').with_value('10')
      end
    end

    context 'with pylibmc backend' do
      let :params do
        {
          :backend => 'dogpile.cache.pylibmc',
        }
      end

      it 'configures cache backend' do
        is_expected.to contain_keystone_config('cache/backend').with_value('dogpile.cache.pylibmc')
        is_expected.to contain_package('python-pylibmc').with(
          :ensure => 'present',
          :name   => platform_params[:pylibmc_package_name],
          :tag    => 'openstack',
        )
      end
    end

    context 'with memcache backend' do
      let :params do
        {
          :backend => 'dogpile.cache.memcache',
        }
      end

      it 'configures cache backend' do
        is_expected.to contain_keystone_config('cache/backend').with_value('dogpile.cache.memcache')
        is_expected.to contain_package('python-memcache').with(
          :name   => platform_params[:python_memcache_package_name],
          :tag    => ['openstack'],
        )
      end
    end

    context 'with string in list parameters' do
      let :params do
        {
          :backend_argument => 'foo:bar',
          :memcache_servers => 'host1:11211,host2:11211',
          :proxies          => 'proxy1,proxy2',
        }
      end

      it 'configures oslo_policy section with overriden list values as strings' do
        is_expected.to contain_keystone_config('cache/backend_argument').with_value('foo:bar')
        is_expected.to contain_keystone_config('cache/memcache_servers').with_value('host1:11211,host2:11211')
        is_expected.to contain_keystone_config('cache/proxies').with_value('proxy1,proxy2')
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
        platform_params = { :pylibmc_package_name => 'python-pylibmc' }

        case facts[:osfamily]
        when 'Debian'
          platform_params[:python_memcache_package_name] = 'python-memcache'
        when 'RedHat'
          platform_params[:python_memcache_package_name] = 'python-memcached'
        end

        platform_params
      end

      it_behaves_like 'oslo-cache'
    end
  end
end
