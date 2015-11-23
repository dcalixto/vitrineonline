class Product::StepsController < ApplicationController

  include Wicked::Wizard
  steps *Product.form_steps


  def show
     @product = Product.find(params[:product_id])
     render_wizard
   end

  def update
    @product = Product.find(params[:product_id])

    if @product.update_attributes(params[:product])
 
     redirect_to vitrine_stocks_path(current_vitrine.id)
    else
          render_wizard @product
    end
  end


  private

 def pet_params(step)
   permitted_attributes = case step
                          when "first"
                            []


                          end


 end
end
