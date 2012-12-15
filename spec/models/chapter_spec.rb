require 'spec_helper'

describe Chapter do
  describe '#finished?' do
    it "is finished when user's mission enrollments for missions of that
      chapter were accomplished" do
      user = create :user
      chapter = create :chapter, game_version: user.game_version, position: 1

      (1..3).each do |mp|
        mission = create(:mission, chapter: chapter, position: mp)
        create(:mission_enrollment, mission: mission, accomplished: true, user: user)
      end

      Chapter.finished?(chapter, user).should be_true
    end
  end
end
