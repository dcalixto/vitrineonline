# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'

 # include Resque::Mailer
add_template_helper(EmailHelper)


  def order_confirmation(order)
  
    @order = order
  

    mail(to: @order.buyer.email, subject: 'Confirmação da Compra', &:html)
 
  
  
  end

 def order_confirmation_seller(order)
  
     @order = order
       mail(to: @order.seller.policy.paypal, subject: 'Confirmação da Venda', &:html)
  end


 def order_track(order)
    @order = order
  

    mail(to: @order.buyer.email, subject: 'Número de Rastreio', &:html)
  end

end
