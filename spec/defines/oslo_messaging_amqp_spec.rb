require 'spec_helper'

describe 'oslo::messaging::amqp' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-messaging-amqp' do

    context 'with default parameters' do
      it 'configure oslo_messaging_amqp default params' do
       is_expected.to contain_keystone_config('oslo_messaging_amqp/addressing_mode').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/server_request_prefix').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/broadcast_prefix').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/group_request_prefix').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/rpc_address_prefix').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/notify_address_prefix').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/multicast_address').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/unicast_address').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/anycast_address').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/default_notification_exchange').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/default_rpc_exchange').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/pre_settled').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/container_name').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/idle_timeout').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/trace').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/ssl_ca_file').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/ssl_cert_file').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/ssl_key_file').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/ssl_key_password').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/allow_insecure_clients').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/sasl_mechanisms').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/sasl_config_dir').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/sasl_config_name').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/username').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/password').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/default_send_timeout').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/default_notify_timeout').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_backend').with_value('amqp')
      end

    end

    context 'with overridden parameters' do
      let :params do
          { :idle_timeout   => 2000,
            :container_name => 'openstack',
            :username       => 'newuser',
            :password       => 'p@ssw0rd',
          }
      end
      it 'configure oslo_messaging_amqp with overriden values' do
        is_expected.to contain_keystone_config('oslo_messaging_amqp/idle_timeout').with_value(2000)
        is_expected.to contain_keystone_config('oslo_messaging_amqp/container_name').with_value('openstack')
        is_expected.to contain_keystone_config('oslo_messaging_amqp/username').with_value('newuser')
        is_expected.to contain_keystone_config('oslo_messaging_amqp/password').with_value('p@ssw0rd')
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

     it_behaves_like 'oslo-messaging-amqp'
    end
  end
end
