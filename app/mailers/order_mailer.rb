# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'

  include Resque::Mailer



  def order_confirmation(order)
    @order = order
    @buyer = order.buyer
    mail(to: @order.buyer.email, subject: 'Confirmação da Compra', &:html)
  end
end
