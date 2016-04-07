require 'spec_helper'

describe 'oslo::messaging::amqp' do

  let (:title) { 'keystone_config' }

  shared_examples 'shared examples' do

    context 'with default parameters' do
      it 'configure oslo_messaging_amqp default params' do
       is_expected.to contain_keystone_config('oslo_messaging_amqp/server_request_prefix').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/broadcast_prefix').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('oslo_messaging_amqp/group_request_prefix').with_value('<SERVICE DEFAULT>')
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
       is_expected.to contain_keystone_config('DEFAULT/rpc_backend').with_value('amqp')
      end

    end

    context 'with overridden parameters' do
      let :params do
          { :idle_timeout => 2000,
            :container_name => 'openstack',
            :username => 'newuser',
            :password => 'p@ssw0rd',
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
