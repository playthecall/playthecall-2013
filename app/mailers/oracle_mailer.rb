class OracleMailer < ActionMailer::Base

  def welcome(oracle)
    mail(to: oracle.email, subject: t('mails.oracle.welcome.subject'))
  end

end
