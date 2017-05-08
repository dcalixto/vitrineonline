class PdatasController < ApplicationController


  def show
    @pdata = Pdata.find(params[:id])
 
    #byebug
    @q = Proback.joins(:pdata).where('pdatas.id = ?', @pdata.id).ransack(params[:q])
    @probacks = @q.result(distinct: true).includes(:user).paginate(per_page: 22, page: params[:page]).order('created_at DESC')

  
  
  end

end
