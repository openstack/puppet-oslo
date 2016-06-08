require 'spec_helper'

describe 'oslo::messaging::zmq' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-messaging-zmq' do

    context 'with default parameters' do
      it 'configure zmq default params' do
       is_expected.to contain_keystone_config('DEFAULT/rpc_cast_timeout').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_poll_timeout').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_bind_address').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_bind_port_retries').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_concurrency').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_contexts').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_host').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_ipc_dir').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_matchmaker').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_max_port').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_min_port').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_topic_backlog').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/use_pub_sub').with_value('<SERVICE DEFAULT>')
       is_expected.to contain_keystone_config('DEFAULT/zmq_target_expire').with_value('<SERVICE DEFAULT>')
      end

    end

    context 'with overridden parameters' do
      let :params do
          { :rpc_zmq_bind_address => '0.0.0.0',
            :rpc_zmq_bind_port_retries => '10',
            :rpc_zmq_concurrency => 'native',
            :rpc_zmq_contexts => '2',
          }
      end

      it 'configure zmq with overriden values' do
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_bind_address').with_value('0.0.0.0')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_bind_port_retries').with_value('10')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_concurrency').with_value('native')
       is_expected.to contain_keystone_config('DEFAULT/rpc_zmq_contexts').with_value('2')
      end
    end

    context 'with wrong zmq concurrency' do
      let :params do
        { :rpc_zmq_concurrency => 'some_another' }
      end

      it_raises 'a Puppet::Error', /Unsupported type of zmq concurrency is used/
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

     it_behaves_like 'oslo-messaging-zmq'
    end
  end
end
