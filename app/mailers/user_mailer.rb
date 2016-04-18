# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: 'Vitrineonline'
include Resque::Mailer
  #def premailer(message)
  #  message.text_part.body = Premailer.new(message.text_part.body.to_s, with_html_string: true).to_plain_text
  #  message.html_part.body = Premailer.new(message.html_part.body.to_s, with_html_string: true).to_inline_css

  #  return message
  #end

  def registration_confirmation(user)
     @user = user
     mail(:to => "#{user.name} <#{user.email}>", :subject => "Confirmar Registro",&:html)
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
