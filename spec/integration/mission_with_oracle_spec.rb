require 'integration_spec_helper'

describe 'Missions with oracle' do

  clean_with_transaction_on :each

  it 'shows an oracle field' do
    mission = create :mission, oracle: true
    user = create :user, game_version: mission.chapter.game_version
    login(user)
    click_link I18n.t('mission.presenter.im_ready')
    page.should have_content I18n.t('mission.oracle_field')
  end

end
