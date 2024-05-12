require 'spec_helper'

describe 'Oslo::TransportURL' do
  describe 'valid types' do
    context 'with valid types' do
      [
        'rabbit://rabbit_user:password@localhost:5673',
        'kombu://rabbit_user:password@localhost:5673',
        'fake://',
        '<SERVICE DEFAULT>',
      ].each do |value|
        describe value.inspect do
          it { is_expected.to allow_value(value) }
        end
      end
    end
  end

  describe 'invalid types' do
    context 'with garbage inputs' do
      [
        'amqp://amqp_user:password@localhost:5672',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end

