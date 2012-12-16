require 'integration_spec_helper'

describe 'Missions with oracle' do

  clean_with_transaction_on :each

  it 'shows an oracle field' do
    user = create :user
    mission = create :mission, oracle: true
    mission_enrollment = create :mission_enrollment, { user: user, mission: mission }
    create :enrollment_image, mission_enrollment: mission_enrollment
    login(user)
    visit mission_enrollment_path nickname: user.nickname, slug: mission.slug
    save_and_open_page
    page.should have_content I18n.t('mission.oracle_field')
  end

end
