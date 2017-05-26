class DisputeMailer < ActionMailer::Base

  default from: 'Vitrineonline'

  # include Resque::Mailer
  add_template_helper(EmailHelper)



  def dispute_confirmation(dispute)
    @dispute = dispute


    mail(to: @dispute.buyer_email, subject: 'Reclamação Enviada', &:html)

    # mail(to: @dispute.seller.email, subject: 'Comprador abriu uma Reclamação', &:html)


  end



def dispute_seller(dispute)
    @dispute = dispute


 
   mail(to: @dispute.seller.email, subject: 'Comprador abriu uma Reclamação', &:html)


  end



  def dispute_update(dispute)

    @dispute = dispute


    mail(to: @dispute.buyer_email, subject: 'Reclamação Enviada', &:html)



  end

  def dispute_finish(dispute)
    @dispute = dispute
    mail(to: @dispute.buyer_email, subject: 'Comprador abriu uma Reclamação', &:html)
  end




end
