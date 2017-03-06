# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'

 # include Resque::Mailer



  def order_confirmation(order)
    order = Order.find(order_id)
    @buyer = order.buyer_id
    mail(to: @buyer.email, subject: 'Confirmação da Compra', &:html)
  end

 def order_confirmation_seller(order)
    order = Order.find(order_id)
    @seller = order.seller_id
    mail(to: @seller.email, subject: 'Confirmação da Venda', &:html)
  end

end
