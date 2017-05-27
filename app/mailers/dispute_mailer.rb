class DisputeMailer < ActionMailer::Base

  default from: 'Vitrineonline'

  # include Resque::Mailer
  add_template_helper(EmailHelper)



  def dispute_confirmation(dispute)
    @dispute = dispute


    mail(to: @dispute.buyer_email, subject: 'Reclamação Aberta', &:html)

    


  end

 def confirmation_seller
   @dispute = dispute


 mail(to: @dispute.seller_email, subject: 'Comprador abriu uma Reclamação', &:html)
 end


  def dispute_update(dispute)

    @dispute = dispute


    mail(to: @dispute.buyer_email, subject: 'Reclamação Atualizada', &:html)



  end




 def update_seller(dispute)

    @dispute = dispute


    mail(to: @dispute.seller_email, subject: 'Reclamação Atualizada', &:html)



  end




def finish_seller(dispute)

    @dispute = dispute


    mail(to: @dispute.seller_email, subject: 'Reclamação Finalizada', &:html)



  end



  def dispute_finish(dispute)
    @dispute = dispute
    mail(to: @dispute.buyer_email, subject: ' Reclamação Finalizada', &:html)
  end




end
