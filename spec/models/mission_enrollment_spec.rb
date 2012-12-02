require 'spec_helper'

describe MissionEnrollment do
  context 'simple mission' do
    clean_with_transaction_on :all

    before :all do
      @mission    = create :mission
      @enrollment = create :mission_enrollment, mission: @mission
    end

    it 'should compile description' do
      @enrollment.should have_description_tag 'em', 'Mission Enrollment'
    end

    it 'should have a validator class' do
      @enrollment.validator.class.should == FacebookSocialMissionValidator
    end

    it 'should have a presenter class' do
      @enrollment.presenter(mock).class.should == FacebookSocialMissionValidatorPresenter
    end

    it 'should have not been accomplished' do
      @enrollment.should_not           be_accomplished
      @enrollment.validator.should_not be_accomplished
    end
  end
end
