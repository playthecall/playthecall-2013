require 'spec_helper'

describe User do
  clean_with_transaction_on :each

  context '::ranking' do
    it 'is empty when there are no users' do
      User.ranking.should be_empty
    end

    it 'orders users by points descending' do
      users = [1,3,2,5].map{|p| create :user, points: p}
      User.ranking.map(&:points).should eql [5,3,2,1]
    end

    it 'is limited to the top 10' do
      11.times{create :user}
      User.ranking.count.should be 10
    end
  end
end
