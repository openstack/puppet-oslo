require 'spec_helper'

describe 'Oslo::Dbconn::Sqlite' do
  describe 'valid types' do
    context 'with valid types' do
      [
        'sqlite:///var/lib/db.db',
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
        'mysql+pymysql://db:db@localhost/db',
        'postgresql://db:db@localhost/db',
        'postgresql+psycopg2://db:db@localhost/db',
        'mongodb://db:db@localhost/db',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end

