require 'integration_spec_helper'

describe 'Missions with oracle' do

  it 'shows an oracle field' do
    user = create :user
    mission = create :mission, oracle: true
    mission_enrollment = mission.enroll user
    login(user)
  end

end
