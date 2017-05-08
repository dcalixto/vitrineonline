class OdatasController < ApplicationController

  def sold


 @q = Odata.where('seller_id = ?', current_vitrine.id).ransack(params[:q])
    

 @odatas = @q.result(distinct: true).paginate(page: params[:page], per_page: 22).order('created_at DESC')




  end



  def purchased


 @q = Odata.where('buyer_id = ?', current_user.id).ransack(params[:q])
    

 @odatas = @q.result(distinct: true).paginate(page: params[:page], per_page: 22).order('created_at DESC')


  end



end
