require 'spec_helper'

describe 'oslo::cache' do

  let (:title) { 'keystone_config' }

  shared_examples 'shared examples' do

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
          :backend_argument                     => 'foo:bar',
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

      it 'configures cache setion' do
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
