# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'

 # include Resque::Mailer



  def order_confirmation(order)
    @order = order
    @buyer = order.buyer
    mail(to: @buyer.email, subject: 'Confirmação da Compra', &:html)
  end

 def order_confirmation_seller(order)
    @order = order
    @seller = order.seller
    mail(to: @seller.email, subject: 'Confirmação da Venda', &:html)
  end

end
