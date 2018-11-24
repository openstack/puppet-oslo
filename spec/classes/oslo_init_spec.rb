require 'spec_helper'

describe 'oslo' do
  shared_examples 'oslo' do
    context 'with default parameters' do
      it { should contain_class('oslo::params') }
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'oslo'
    end
  end
end
