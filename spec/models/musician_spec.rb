require 'spec_helper'

describe "Musician Model" do
  let(:musician) { Musician.new }
  it 'can be created' do
    musician.should_not be_nil
  end
end
