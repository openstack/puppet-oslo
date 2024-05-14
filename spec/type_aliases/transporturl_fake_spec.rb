require 'spec_helper'

describe 'Oslo::TransportURL::Fake' do
  describe 'valid types' do
    context 'with valid types' do
      [
        'fake://'
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
        'fakes://',
        'afake://',
        'fake://host',
        'fake:/',
        'fake:///',
        'rabbit://rabbit_user:password@localhost:5673',
        '<SERVICE DEFAULT>',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end

