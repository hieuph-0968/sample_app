class UserMailer < ApplicationMailer
  def account_activation user
    @user = useru
    mail to: user.email, subject: I18n.t("user_mailer.account_mail")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: I18n.t("user_mailer.reset_password")
  end
end
