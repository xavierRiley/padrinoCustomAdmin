require 'spec_helper'

describe "AdminConfiguration Model" do
  let(:admin_configuration) { AdminConfiguration.new }
  it 'can be created' do
    admin_configuration.should_not be_nil
  end
end
