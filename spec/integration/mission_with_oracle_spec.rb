require 'spec_helper'

describe 'Missions with oracle' do

  it 'shows an oracle field' do
    user = create :user
    mission = create :mission, oracle: true
    mission_enrollment = mission.enroll user
    login(user)
  end

  def login(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

end
