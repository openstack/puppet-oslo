require 'spec_helper'

describe 'oslo::messaging::rabbit' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-messaging-rabbit' do

    context 'with default parameters' do
      it 'configure oslo_messaging_rabbit default params' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/amqp_durable_queues').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_reconnect_delay').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_missing_consumer_retry_timeout').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_failover_strategy').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_compression').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_qos_prefetch_count').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_login_method').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_retry_interval').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_retry_backoff').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_interval_max').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_transient_queues_ttl').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_timeout_threshold').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_rate').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_in_pthread').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_queue').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_delivery_limit').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_max_memory_length').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_max_memory_bytes').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with overridden parameters' do
      let :params do
        {
          :rabbit_qos_prefetch_count       => 10,
          :heartbeat_timeout_threshold     => 60,
          :heartbeat_rate                  => 10,
          :heartbeat_in_pthread            => true,
          :kombu_compression               => 'bz2',
          :rabbit_ha_queues                => true,
          :rabbit_quorum_queue             => true,
          :rabbit_quorum_delivery_limit    => 3,
          :rabbit_quorum_max_memory_length => 5,
          :rabbit_quorum_max_memory_bytes  => 1073741824,
        }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_qos_prefetch_count').with_value(10)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_timeout_threshold').with_value(60)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_rate').with_value(10)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_in_pthread').with_value(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_compression').with_value('bz2')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_queue').with_value(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_delivery_limit').with_value(3)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_max_memory_length').with_value(5)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_quorum_max_memory_bytes').with_value(1073741824)
      end
    end

    context 'with rabbit ssl enabled with kombu' do
      let :params do
        { :rabbit_use_ssl     => true,
          :kombu_ssl_ca_certs => '/etc/ca.cert',
          :kombu_ssl_certfile => '/etc/certfile',
          :kombu_ssl_keyfile  => '/etc/key',
          :kombu_ssl_version  => 'TLSv1', }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl').with_value(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_ca_file').with_value('/etc/ca.cert')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_cert_file').with_value('/etc/certfile')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_key_file').with_value('/etc/key')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_version').with_value('TLSv1')
      end
    end

    context 'with rabbit ssl enabled without kombu' do
      let :params do
        { :rabbit_use_ssl => true }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl').with_value(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_ca_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_cert_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_key_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/ssl_version').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with incorrect kombu compression' do
      let :params do
        { :kombu_compression => 'foo' }
      end

      it { is_expected.to raise_error Puppet::Error, /Unsupported Kombu compression. Possible values are gzip and bz2/ }
    end

    context 'with kombu_ssl_ca_certs enabled without ssl usage' do
      let :params do
        { :kombu_ssl_ca_certs => '/etc/ca.cert' }
      end

      it { is_expected.to raise_error Puppet::Error, /The kombu_ssl_ca_certs parameter requires rabbit_use_ssl to be set to true/ }
    end

    context 'with kombu_ssl_certfile set without rabbit ssl usage' do
      let :params do
        { :kombu_ssl_certfile => '/tmp/foo' }
      end

      it { is_expected.to raise_error Puppet::Error, /The kombu_ssl_certfile parameter requires rabbit_use_ssl to be set to true/ }
    end

    context 'with kombu_ssl_version set without rabbit ssl usage' do
      let :params do
        { :kombu_ssl_version => 'foo' }
      end

      it { is_expected.to raise_error Puppet::Error, /The kombu_ssl_version parameter requires rabbit_use_ssl to be set to true/ }
    end

    context 'with kombu_ssl_certfile set without kombu_ssl_keyfile' do

      let :params do
        { :rabbit_use_ssl     => true,
          :kombu_ssl_ca_certs => '/etc/ca.cert',
          :kombu_ssl_certfile => '/etc/certfile',
          :kombu_ssl_version  => 'TLSv1', }
      end

      it { is_expected.to raise_error Puppet::Error, /The kombu_ssl_certfile parameter and the kombu_ssl_keyfile parameters must be used together/ }
    end

    context 'with kombu_ssl_keyfile set without kombu_ssl_certfile' do

      let :params do
        { :rabbit_use_ssl     => true,
          :kombu_ssl_ca_certs => '/etc/ca.cert',
          :kombu_ssl_keyfile  => '/etc/key',
          :kombu_ssl_version  => 'TLSv1', }
      end

      it { is_expected.to raise_error Puppet::Error, /The kombu_ssl_certfile parameter and the kombu_ssl_keyfile parameters must be used together/ }
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

     it_behaves_like 'oslo-messaging-rabbit'
    end
  end
end
