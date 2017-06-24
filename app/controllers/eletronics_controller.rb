class EletronicsController < ApplicationController


 # include GenderHelper


 def index
@eletronics = Eltronic.all
 end

  def show
    @eletronic = Eletronic.find(params[:id])
    @products = Product.aggs_search(params.merge(eletronic_id: @eletronic.id))
    if request.path != eletronic_path(@eletronic)
      redirect_to @eletronic, status: :moved_permanently
    end

    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

  end





 



end
