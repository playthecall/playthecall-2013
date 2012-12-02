require 'spec_helper'

describe Mission do

  context 'simple mission' do
    clean_with_transaction_on :all

    before do
      @user = create :user
      @game_version = @user.game_version
      @chapter = create :chapter, game_version: @game_version
      @mission = create :mission, chapter: @chapter
    end

    it 'should compile description' do
      @mission.should have_description_tag 'em', 'Content'
    end
  end

  context 'next_for & current_for' do
    clean_with_transaction_on :all

    before :all do
      @user = create :user
      @game_version = @user.game_version
      @chapters = []
      @missions = {}
      (1..2).each do |cp|
        chapter = create :chapter, game_version: @game_version, position: cp
        @chapters << chapter
        @missions[chapter.id] = []
        (1..3).each do |mp|
          @missions[chapter.id] << create(:mission, chapter: chapter, position: mp)
        end
      end
    end

    context 'user has no mission enrollment' do
      it 'gets first mission from first chapter' do
        Mission.current_for(@user).should be_nil
        Mission.next_for(@user).should eql @missions[@chapters.first.id].first
      end
    end

    context 'user is enrolled on first mission' do
      it 'gets first mission from first chapter' do
        create :mission_enrollment, user: @user, mission: @missions[@chapters.first.id].first
        Mission.current_for(@user).should eql @missions[@chapters.first.id].first
        Mission.next_for(@user).should    eql @missions[@chapters.first.id].second
      end
    end
  end
end
