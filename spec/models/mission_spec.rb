require 'spec_helper'

describe Mission do
  clean_with_transaction_on :all

  before :all do
    @mission = create :mission
  end

  it 'should compile description' do
    @mission.should have_description_tag 'em', 'Content'
  end
end
