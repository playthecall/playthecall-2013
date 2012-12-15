require 'spec_helper'

describe User do
  clean_with_transaction_on :each

  let(:user) { create :user }

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

  describe "#current_chapter" do
    it "gets the first chapter of the game_version if no mission was finished" do
      chapter = create :chapter, game_version: user.game_version, position: 1
      user.current_chapter.should == chapter
    end

    it "gets the first chapter that was not finished from user's game_version" do
      finished_chapter   = create :chapter, game_version: user.game_version, position: 1
      unfinished_chapter = create :chapter, game_version: user.game_version, position: 3
      chapter           = create :chapter, game_version: user.game_version, position: 2

      (1..3).each do |mp|
        mission = create(:mission, chapter: finished_chapter, position: mp)
        create(:mission_enrollment, mission: mission, user: user, accomplished: true)

        mission = create(:mission, chapter: unfinished_chapter, position: mp)
        create(:mission_enrollment, mission: mission, user: user, accomplished: false)

        mission = create(:mission, chapter: chapter, position: mp)
        create(:mission_enrollment, mission: mission, user: user, accomplished: false)
      end

      user.current_chapter.should == chapter
    end
  end

  describe "#current_mission" do
    it "gets first mission if no mission_enrollment is present" do
      chapter = create :chapter, game_version: user.game_version, position: 1
      mission = create(:mission, chapter: chapter, position: 1)

      user.current_mission.should == mission
    end

    it "gets next mission if there is accomplished mission_enrollment" do
      chapter = create :chapter, game_version: user.game_version, position: 1
      finished_mission = create(:mission, chapter: chapter, position: 1)
      create(:mission_enrollment, mission: finished_mission, user: user, accomplished: true)

      mission = create(:mission, chapter: chapter, position: 2)

      user.current_mission.should == mission
    end

    it "gets the first mission not accomplished" do
      chapter = create :chapter, game_version: user.game_version, position: 1

      finished_mission = create(:mission, chapter: chapter, position: 1)
      create(:mission_enrollment, mission: finished_mission, user: user, accomplished: true)

      unfinished_mission = create(:mission, chapter: chapter, position: 3)
      create(:mission_enrollment, mission: unfinished_mission, user: user, accomplished: false)

      mission = create(:mission, chapter: chapter, position: 2)
      create(:mission_enrollment, mission: mission, user: user, accomplished: false)
      user.current_chapter.should == mission.chapter
      user.current_mission.should == mission
    end
  end

  describe "#current_mission_enrollment" do
    before do
      chapter = create :chapter, game_version: user.game_version, position: 1

      mission             = create(:mission, chapter: chapter, position: 1)
      @mission_enrollment = create(:mission_enrollment, mission: mission,
                                           user: user, accomplished: false)
    end

    it "gets the mission_enrollment associated to #current_mission" do
      user.current_mission.should == @mission_enrollment.mission
      user.current_mission_enrollment.should == @mission_enrollment
    end
  end
end
