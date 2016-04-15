require 'spec_helper'

describe 'oslo' do

  shared_examples 'oslo' do

    context 'with default parameters' do
     it 'contains the logging class' do
       is_expected.to contain_class('oslo::params')
     end
    end

  end

end
