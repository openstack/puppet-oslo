require 'spec_helper'

describe 'oslo::messaging::notifications' do

  let (:title) { 'keystone_config' }

  shared_examples 'notifications examples' do

    context 'with default parameters' do
      it 'configure oslo_messaging_notifications default params' do
        is_expected.to contain_keystone_config('oslo_messaging_notifications/driver').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_notifications/transport_url').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_keystone_config('oslo_messaging_notifications/topics').with_value('<SERVICE DEFAULT>')
      end

    end

    context 'with overridden parameters' do
      let :params do
          { :driver        => 'messaging',
            :transport_url => 'some_protocol://some_url',
            :topics        => 'notifications',
          }
      end

      it 'configure oslo_messaging_notifications with overriden values' do
        is_expected.to contain_keystone_config('oslo_messaging_notifications/driver').with_value('messaging')
        is_expected.to contain_keystone_config('oslo_messaging_notifications/transport_url').with_value('some_protocol://some_url')
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

      it_behaves_like 'notifications examples'
    end
  end
end
