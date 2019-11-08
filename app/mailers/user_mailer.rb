class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: t("user_mailer.Account_mail")
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: t("user_mailer.reset_password")
  end
end
