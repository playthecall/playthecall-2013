class OracleMailer < ActionMailer::Base

  def welcome(mission_enrollment)
    oracle = mission_enrollment.oracle
    mail(to: oracle.email, subject: "Welcome to My Awesome Site")
  end

end
