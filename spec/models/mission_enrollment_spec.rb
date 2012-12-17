require 'spec_helper'

describe MissionEnrollment do

  let(:mission) { create :mission }
  subject       { create :mission_enrollment, mission: mission }

  context 'simple mission' do
    clean_with_transaction_on :all

    it 'should compile description' do
      subject.should have_description_tag 'em', 'Mission Enrollment'
    end

    it 'should have a validator class' do
      subject.validator.class.should == FacebookSocialMissionValidator
    end

    it 'should have a presenter class' do
      subject.presenter(mock).class.should == FacebookSocialMissionValidatorPresenter
    end

    it 'should have not been accomplished' do
      subject.should_not           be_accomplished
      subject.validator.should_not be_accomplished
    end
  end

  context '#notify_oracle' do
    clean_with_transaction_on :each

    it 'does nothing if there is no oracle' do
      OracleMailer.should_not_receive(:anything)
      subject.notify_oracle
    end

    it 'sends the welcome mail when the oracle is new' do
      subject.oracle = build :oracle
      welcome_mail = mock
      welcome_mail.should_receive(:deliver)
      OracleMailer.should_receive(:welcome).with(subject).
                   and_return(welcome_mail)
      subject.notify_oracle
    end

    it 'sends the usual mail when the oracle is already created' do
      subject.oracle = create :oracle
      mission_notification = mock
      mission_notification.should_receive(:deliver)
      OracleMailer.should_receive(:mission_notification).with(subject).
                   and_return(mission_notification)
      subject.notify_oracle
    end
  end
end
