class DisputeMailer < ActionMailer::Base
 
 default from: 'Vitrineonline'

 # include Resque::Mailer
add_template_helper(EmailHelper)



  def dispute_confirmation(dispute)
    @dispute = dispute
  

    mail(to: @dispute.buyer.email, subject: 'Reclamação Enviada', &:html)
 
 # mail(to: @dispute.seller.email, subject: 'Comprador abriu uma Reclamação', &:html)

  
  end


 # def buyer_dispute(dispute)
  
 #   @dispute = dispute
  

 ##   mail(to: @dispute.buyer.email, subject: 'Reclamação Enviada', &:html)
 
  
  
 # end

# def seller_dispute(dispute)
# @dispute = dispute
 #   mail(to: @dispute.seller.email, subject: 'Comprador abriu uma Reclamação', &:html)
 # end




end
