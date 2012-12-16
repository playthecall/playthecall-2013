require 'integration_spec_helper'

describe 'Missions with oracle' do

  context 'user enters in new mission enrollment page' do

    clean_with_transaction_on :each

    let(:mission) { create :mission, oracle: true }
    let(:user) { create :user, game_version: mission.chapter.game_version }

    before :each do
      login(user)
      click_link t('mission.presenter.im_ready')
    end

    it 'shows an oracle field' do
      save_and_open_page
      page.should have_content t('mission.oracle_field')
    end

    context 'fills the oracle field, and submit' do
      it 'associates the mission enrollment with the oracle' do
        oracle = build(:oracle)
        mission_enrollment = build(:mission_enrollment)
        fill_in t('mission.oracle_field'), with: oracle.email
        fill_in t('activerecord.attributes.mission_enrollment.description'),
                with: mission_enrollment.description
        attach_file t('activerecord.attributes.enrollment_image.image'),
                    'app/assets/images/rails.png'
        click_button t('actions.save')
        user.mission_enrollments.first.oracle.email.should eql oracle.email
      end
    end

  end

end
