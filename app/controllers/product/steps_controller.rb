class Product::StepsController < ApplicationController
  include Wicked::Wizard

  steps :first

  def show
    @product = Product.find(params[:product_id])
    render_wizard
  end

  def update
    @product = Product.find(params[:product_id])
    params[:product][:state] = 'active' if step == steps.last
    @product.update_attributes(params[:product])
    render_wizard @product
  end
end
