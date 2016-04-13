class Contact < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :subject,      attachment: true
  append :remote_ip, :user_agent, :session
  attribute :message
  # attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  include ActiveModel::Validations
  
  def headers
    {
      subject: 'My Contact Form',
      to: 'contato@vitrineonline.com',
      from: %("#{name}" <#{email}>)
    }
  end
end
