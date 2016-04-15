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
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_hosts').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_userid').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_password').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_login_method').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_virtual_host').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_retry_interval').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_retry_backoff').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_interval_max').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_max_retries').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_transient_queues_ttl').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_timeout_threshold').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_rate').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_backend').with_value('rabbit')
      end
    end

    context 'with overridden parameters' do
      let :params do
        { :rabbit_host                 => 'rabbit',
          :rabbit_userid               => 'rabbit_user',
          :rabbit_port                 => '5673',
          :rabbit_password             => 'password',
          :heartbeat_timeout_threshold => '60',
          :heartbeat_rate              => '10',
          :rabbit_virtual_host         => '/',
          :kombu_compression           => 'bz2', }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_host').with_value('rabbit')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_password').with_value('password').with_secret(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_port').with_value('5673')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_userid').with_value('rabbit_user')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_virtual_host').with_value('/')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_timeout_threshold').with_value('60')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/heartbeat_rate').with_value('10')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_compression').with_value('bz2')
      end
    end

    context 'with rabbit_hosts parameter (one server)' do
      let :params do
        { :rabbit_hosts => ['rabbit:5672'] }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_hosts').with_value('rabbit:5672')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with rabbit_hosts parameter' do
      let :params do
        { :rabbit_hosts => ['rabbit1:5672', 'rabbit2:5673'] }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_hosts').with_value('rabbit1:5672,rabbit2:5673')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value(true)
      end
    end

    context 'with rabbit_hosts parameter and disabled rabbit_ha_queues' do
      let :params do
        { :rabbit_hosts     => ['rabbit1:5672', 'rabbit2:5673'],
          :rabbit_ha_queues => false, }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_host').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_hosts').with_value('rabbit1:5672,rabbit2:5673')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value(false)
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
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_ca_certs').with_value('/etc/ca.cert')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_certfile').with_value('/etc/certfile')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_keyfile').with_value('/etc/key')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_version').with_value('TLSv1')
      end
    end

    context 'with rabbit ssl enabled without kombu' do
      let :params do
        { :rabbit_use_ssl => true }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_use_ssl').with_value(true)
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_ca_certs').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_certfile').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_keyfile').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/kombu_ssl_version').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with rabbit host set without rabbit port' do
      let :params do
        { :rabbit_host => 'rabbit1' }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_host').with_value('rabbit1')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_port').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_hosts').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'with rabbit host and port' do
      let :params do
        { :rabbit_host => 'rabbit1',
          :rabbit_port => '5673' }
      end

      it 'configures rabbit' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_host').with_value('rabbit1')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_port').with_value('5673')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_hosts').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_ha_queues').with_value('<SERVICE DEFAULT>')
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

    context 'with string in list parameters' do
      let :params do
        { :rabbit_hosts => 'rabbit1:5672,rabbit2:5673' }
      end

      it 'configures rabbit with overriden list values as strings' do
        is_expected.to contain_keystone_config('oslo_messaging_rabbit/rabbit_hosts').with_value('rabbit1:5672,rabbit2:5673')
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

     it_behaves_like 'oslo-messaging-rabbit'
    end
  end
end
