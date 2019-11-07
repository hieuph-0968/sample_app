class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: t(".Account_mail")
  end
end
