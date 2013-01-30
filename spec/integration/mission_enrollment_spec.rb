require 'integration_spec_helper'

describe 'Mission enrollment' do
  clean_with_transaction_on :each

  context 'When user is not logged in' do
    let(:enrollment) { create :mission_enrollment }
    it 'shows my friend enrollment' do
      visit mission_enrollment_path(enrollment.user_nickname,enrollment.mission.slug)
      page.should have_content enrollment.mission.title
      page.should_not have_content t("actions.update_status")
    end
  end

  context 'When user is logged in' do
    let(:mission) { create :mission }
    let(:user) { create :user, game_version: mission.chapter.game_version }
    let(:enrollment) { mission.enroll(user) }

    before :each do
      login(user)
      enrollment.save!
    end

    it 'shows my mission enrollment' do
      visit mission_enrollment_path(user.nickname, mission.slug)
      page.should have_content mission.title
      page.should have_content t("actions.update_status")
    end
  end
end
