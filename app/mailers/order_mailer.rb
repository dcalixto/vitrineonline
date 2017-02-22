# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: 'Vitrineonline'

 # include Resque::Mailer




  def order_confirmation(order)
    @order = order
    @buyer = user
    mail(to: @buyer.email, subject: 'Confirmação da Compra', &:html)
  end

 def order_confirmation_seller(order)
    @order = order
    @seller = vitrine
    mail(to: @seller.email, subject: 'Confirmação da Venda', &:html)
  end

end
