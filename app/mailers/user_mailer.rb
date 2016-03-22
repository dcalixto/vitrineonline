# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: 'Vitrineonline'

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Resetado'
  end

  def new_password(user)
    @user = user
    mail to: user.email, subject: 'Password Alterado'
   end

  def user_welcome(user)
    @user = user
    mail to: user.email, subject: 'Bem Vindo', &:html
  end
end
