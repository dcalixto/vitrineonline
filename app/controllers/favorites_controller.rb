class FavoritesController < ApplicationController
 
  
  def products

  
  @q = current_user.favorite_products.ransack(params[:q])
  @favorite_products = @q.result(distinct: true).paginate(page: params[:page], per_page: 1)

  end
def vitrines
    @q = current_user.favorite_vitrines.ransack(params[:q])
 @favorite_vitrines = @q.result(distinct: true).paginate(page: params[:page], per_page: 15)
end

  def unmark_product
    @user = current_user
    @product = Product.find(params[:id])
    @product.users_have_marked_as_favorite.delete @user
    redirect_to :back
  end

  def unmark_vitrine
    @user = current_user
    @vitrine = Vitrine.find(params[:id])
    @vitrine.users_have_marked_as_favorite.delete @user
    redirect_to :back
  end


end
