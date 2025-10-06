require 'spec_helper'

describe 'Oslo::Dbconn::Conn_params' do
  describe 'valid types' do
    context 'with valid types' do
      [
        'ssl=true&ssl_ca=/tmp/ca.crt',
        { 'ssl' => 'true', 'ssl_ca' => '/tmp/ca.crt' },
        { 'ssl' => true, 'int' => 23 },
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
        [ 'ssl=true', 'ssl_ca=/tmp/ca.crt' ],
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end

