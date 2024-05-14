require 'spec_helper'

describe 'Oslo::TransportURL::Rabbit' do
  describe 'valid types' do
    context 'with valid types' do
      [
        'rabbit://rabbit_user:password@localhost:5673',
        'kombu://rabbit_user:password@localhost:5673',
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
        'rabbits://rabbit_user:password@localhost:5673',
        'arabbit://rabbit_user:password@localhost:5673',
        'rabbit:/rabbit_user:password@localhost:5673',
        'rabbit:///rabbit_user:password@localhost:5673',
        'rabbit://',
        'kombus://rabbit_user:password@localhost:5673',
        'akombu://rabbit_user:password@localhost:5673',
        'kombu:/rabbit_user:password@localhost:5673',
        'kombu:///rabbit_user:password@localhost:5673',
        'kombu://',
        'fake://',
        '<SERVICE DEFAULT>',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end

