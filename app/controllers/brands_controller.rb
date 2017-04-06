class BrandsController < ApplicationController

  def new
    @brand = current_vitrine.build_brand(params[:brand])
  end
       
  def create
    @brand = current_vitrine.build_brand(params[:brand])
     
    if @brand.save
 
      @current_vitrine = params[:branded] == "1"
      
      @current_vitrine.update_attributes(:branded => true)
      redirect_to new_product_path
flash[:success] = "Sua marca foi adicionada".html_safe
    end

  end
end




