class ProofsController < ApplicationController


def create
 
    @order = Order.find(params[:order_id])
  @dispute = @order.dispute

@proof = @dispute.proofs.create



  if @proof.save

 params[:proofs]['file'].each do |a|
          @proof = @dispute.images.create!(:file => a)
       end


    

   redirect_to order_dispute_path
  end
end




end
