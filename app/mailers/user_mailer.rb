# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: 'VITRINEONLINE'
  include Resque::Mailer


  def registration_confirmation(user)
    #user = User.find(user_id)

   
    @user = user
    mail(to: user.email, subject: 'Confirmar Registro', &:html)
  end




  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Resetado', &:html
  end

  def new_password(user)
    @user = user
    mail to: user.email, subject: 'Password Alterado', &:html
   end

  def user_welcome(user)
    @user = user
    mail to: user.email, subject: 'Bem Vindo', &:html
  end
end
