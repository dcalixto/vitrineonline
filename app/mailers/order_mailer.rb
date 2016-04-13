# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'



#  def premailer(message)
#    message.text_part.body = Premailer.new(message.text_part.body.to_s, with_html_string: true).to_plain_text
#    message.html_part.body = Premailer.new(message.html_part.body.to_s, with_html_string: true).to_inline_css

#    return message
#  end

  def order_confirmation(order)
    @order = order
    @buyer = order.buyer
    mail(to: @order.buyer.email, subject: 'Confirmação da Compra', &:html)
  end
end
