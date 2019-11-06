class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: I18n.t(".account_mail")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: I18n.t(".reset_password")
  end
end
