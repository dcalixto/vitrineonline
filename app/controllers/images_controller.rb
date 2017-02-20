class ImagesController < ApplicationController

  def create 

    respond_to do |format|
      format.html do

         @product = current_vitrine.products.build(params[:product])
        @image = @product.images.build(params[:image])
      end
      format.json do
     @product = current_vitrine.products.build(params[:product])
      render :nothing => true
    end
  end


  end

  end
