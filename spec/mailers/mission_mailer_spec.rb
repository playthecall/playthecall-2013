require "spec_helper"

describe MissionMailer do
  let(:mission) { mock_model(Mission, :id => -1) }
  let(:mission_enrollment) { mock_model(MissionEnrollment, :mission => mission) }
  let(:user) { mock_model(User, :email => 'test@email.com') }

  describe "#accomplished_mission" do
    subject { MissionMailer.accomplished_mission(mission_enrollment, user) }
    it 'should send accomplished e-mail' do
      expect { subject.deliver }.to change(ActionMailer::Base.deliveries, :size)
    end
  end
end
