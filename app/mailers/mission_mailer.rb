class MissionMailer < ActionMailer::Base
  def accomplished_mission(mission_enrollment, user)
    @mission = mission_enrollment.mission
    mail(:to => user.email, :subject => I18n.t('mails.accomplished_mission.subject'))
  end
end
