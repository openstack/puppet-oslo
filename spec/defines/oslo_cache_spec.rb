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
        is_expected.to contain_keystone_config('cache/enable_socket_keepalive').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/socket_keepalive_idle').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/socket_keepalive_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/socket_keepalive_count').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_pool_maxsize').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_pool_unused_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/memcache_pool_connection_get_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/tls_enabled').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/tls_cafile').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/tls_certfile').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/tls_keyfile').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('cache/tls_allowed_ciphers').with_value('<SERVICE DEFAULT>')
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
          :memcache_servers                     => ['host1:11211', 'host2:11211','[fd12:3456:789a:1::1]:11211'],
          :memcache_dead_retry                  => '300',
          :memcache_socket_timeout              => '3.0',
          :enable_socket_keepalive              => false,
          :socket_keepalive_idle                => 1,
          :socket_keepalive_interval            => 1,
          :socket_keepalive_count               => 1,
          :memcache_pool_maxsize                => '10',
          :memcache_pool_unused_timeout         => '60',
          :memcache_pool_connection_get_timeout => '10',
          :tls_enabled                          => false,
          :tls_cafile                           => nil,
          :tls_certfile                         => nil,
          :tls_keyfile                          => nil,
          :tls_allowed_ciphers                  => nil,
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
        is_expected.to contain_keystone_config('cache/memcache_servers').with_value('host1:11211,host2:11211,inet6:[fd12:3456:789a:1::1]:11211')
        is_expected.to contain_keystone_config('cache/memcache_dead_retry').with_value('300')
        is_expected.to contain_keystone_config('cache/memcache_socket_timeout').with_value('3.0')
        is_expected.to contain_keystone_config('cache/enable_socket_keepalive').with_value('false')
        is_expected.to contain_keystone_config('cache/socket_keepalive_idle').with_value('1')
        is_expected.to contain_keystone_config('cache/socket_keepalive_interval').with_value('1')
        is_expected.to contain_keystone_config('cache/socket_keepalive_count').with_value('1')
        is_expected.to contain_keystone_config('cache/memcache_pool_maxsize').with_value('10')
        is_expected.to contain_keystone_config('cache/memcache_pool_unused_timeout').with_value('60')
        is_expected.to contain_keystone_config('cache/memcache_pool_connection_get_timeout').with_value('10')
        is_expected.to contain_keystone_config('cache/tls_enabled').with_value('false')
        is_expected.to contain_keystone_config('cache/tls_cafile').with_value('nil')
        is_expected.to contain_keystone_config('cache/tls_certfile').with_value('nil')
        is_expected.to contain_keystone_config('cache/tls_keyfile').with_value('nil')
        is_expected.to contain_keystone_config('cache/tls_allowed_ciphers').with_value('nil')
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

      context 'with backend package management disabled' do
        before do
          params.merge!({
            :manage_backend_package => false,
          })
        end

        it 'does not install backend package' do
          is_expected.not_to contain_package('python-pylibmc')
        end
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

      context 'with backend package management disabled' do
        before do
          params.merge!({
            :manage_backend_package => false,
          })
        end

        it 'does not install backend package' do
          is_expected.not_to contain_package('python-memcache')
        end
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

      it 'configures oslo_policy section with overridden list values as strings' do
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
        case facts[:osfamily]
        when 'Debian'
          platform_params = { :pylibmc_package_name => 'python3-pylibmc' }
        when 'RedHat'
          platform_params = { :pylibmc_package_name => 'python-pylibmc' }
        end

        case facts[:osfamily]
        when 'Debian'
          platform_params[:python_memcache_package_name] = 'python3-memcache'
        when 'RedHat'
          platform_params[:python_memcache_package_name] = 'python-memcached'
        end

        platform_params
      end

      it_behaves_like 'oslo-cache'
    end
  end
end
