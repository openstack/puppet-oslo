require 'spec_helper'

describe 'oslo::messaging::notifications' do

  let (:title) { 'keystone_config' }

  shared_examples 'oslo-messaging-notifications' do

    context 'with default parameters' do
      it 'configure oslo_messaging_notifications default params' do
        is_expected.to contain_keystone_config('oslo_messaging_notifications/driver').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_notifications/transport_url').with_value('<SERVICE DEFAULT>').with_secret(true)
        is_expected.to contain_keystone_config('oslo_messaging_notifications/topics').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_notifications/retry').with_value('<SERVICE DEFAULT>')
      end

    end

    context 'with overridden parameters' do
      let :params do
          { :driver        => ['messaging', 'messagingv2'],
            :transport_url => 'some_protocol://some_url',
            :topics        => ['foo', 'baa'],
            :retry         => -1,
          }
      end

      it 'configure oslo_messaging_notifications with overridden values' do
        is_expected.to contain_keystone_config('oslo_messaging_notifications/driver').with_value(['messaging', 'messagingv2'])
        is_expected.to contain_keystone_config('oslo_messaging_notifications/transport_url').with_value('some_protocol://some_url').with_secret(true)
        is_expected.to contain_keystone_config('oslo_messaging_notifications/topics').with_value('foo,baa')
        is_expected.to contain_keystone_config('oslo_messaging_notifications/retry').with_value(-1)
      end
    end

    context 'with a single item in lists' do
      let :params do
          { :driver        => ['messaging'],
            :topics        => ['notifications'],
          }
      end

      it 'configure oslo_messaging_notifications with overridden values' do
        is_expected.to contain_keystone_config('oslo_messaging_notifications/driver').with_value(['messaging'])
        is_expected.to contain_keystone_config('oslo_messaging_notifications/topics').with_value('notifications')
      end
    end

    context 'with string in list parameters' do
      let :params do
        {
          :driver => 'messaging',
          :topics => 'notifications',
        }
      end

      it 'configures oslo_messaging_notifications section with overridden list values as strings' do
        is_expected.to contain_keystone_config('oslo_messaging_notifications/driver').with_value('messaging')
        is_expected.to contain_keystone_config('oslo_messaging_notifications/topics').with_value('notifications')
      end
    end
  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'oslo-messaging-notifications'
    end
  end
end
