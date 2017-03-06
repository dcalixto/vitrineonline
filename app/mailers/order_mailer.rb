# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'

 # include Resque::Mailer



  def order_confirmation(order)
    @order = order

   order.buyer = current_user

    mail(to: order.buyer.email, subject: 'Confirmação da Compra', &:html)
 
  
  
  end

 def order_confirmation_seller(order)
     @order = order
    order.seller = product.vitrine
    mail(to: order.seller.email, subject: 'Confirmação da Venda', &:html)
  end

end
