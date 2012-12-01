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

  context 'multiple missions' do
    clean_with_transaction_on :all

    before :all do
      @user     = create :user
      @missions = []

      (1..3).each do |p|
        @missions << create(:mission, game_version_id: @user.game_version_id, position: p)
        @missions << create(:mission, game_version_id: @user.game_version_id, position: p, element: 'fire')
      end
    end

    it 'should create first enrollment from first mission' do
      mission = @user.current_mission_enrollment.mission
      mission.position.should == 1
      mission.element.should be_blank
    end

    it 'should get same enrollment when mission is not finished' do
      mission = @user.current_mission_enrollment.mission
      mission.position.should == 1
      mission.element.should be_blank
    end

    it 'should get second enrollment when mission is not finished' do
      @user.current_mission_enrollment.should_not be_accomplished
      @user.current_mission_enrollment.update_attribute :accomplished, true
      mission = @user.reload.current_mission_enrollment.mission
      mission.position.should == 2
      mission.element.should be_blank
    end

    it 'should get third enrollment when mission is not finished' do
      @user.current_mission_enrollment.should_not be_accomplished
      @user.current_mission_enrollment.update_attribute :accomplished, true
      mission = @user.reload.current_mission_enrollment.mission
      mission.position.should == 3
      mission.element.should be_blank
    end

    it 'should get first enrollment when choosed new element' do
      @user.update_attribute :element, 'fire'
      @user.current_mission_enrollment.should_not be_accomplished
      @user.current_mission_enrollment.update_attribute :accomplished, true
      mission = @user.reload.current_mission_enrollment.mission
      mission.position.should == 1
      mission.element.should  == 'fire'
    end

    it 'should get second enrollment when mission is not finished with new element' do
      @user.current_mission_enrollment.should_not be_accomplished
      @user.current_mission_enrollment.update_attribute :accomplished, true
      mission = @user.reload.current_mission_enrollment.mission
      mission.position.should == 2
      mission.element.should  == 'fire'
    end

    it 'should get third enrollment when mission is not finished with new element' do
      @user.current_mission_enrollment.should_not be_accomplished
      @user.current_mission_enrollment.update_attribute :accomplished, true
      mission = @user.reload.current_mission_enrollment.mission
      mission.position.should == 3
      mission.element.should  == 'fire'
    end

    it "should get last_enrollment, even if it's accomplished when there isn't any more missions" do
      last_enrollment = @user.current_mission_enrollment
      @user.current_mission_enrollment.update_attribute :accomplished, true
      @user.reload.current_mission_enrollment.should == last_enrollment
    end
  end
end
