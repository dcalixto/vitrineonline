# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'

 # include Resque::Mailer



  def order_confirmation(order)
    order_identification = order.order_id 
    @user = order.buyer_id
    mail(to: @user.email, subject: 'Confirmação da Compra', &:html)
  end

 def order_confirmation_seller(order)
    order_identification = order.order_id 
    @vitrine = order.seller_id
    mail(to: @seller.email, subject: 'Confirmação da Venda', &:html)
  end

end
