require 'spec_helper'
describe 'puppet_agent_migrate' do
  context 'with default values for all parameters' do
    it { should contain_class('puppet_agent_migrate') }
  end
end
