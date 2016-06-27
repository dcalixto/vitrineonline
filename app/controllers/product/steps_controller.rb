# encoding: utf-8
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

      #facebook sharing
      if @product.is_shared_on_facebook
        begin
          client = Koala::Facebook::API.new cookies[:facebook_auth_token]
          options = {
              :name => @product.name,
              :link => product_url(@product),
              :caption => "#{current_user.full_name} posted a new product",
              :description => @product.detail
          }
          options[:picture] = (root_url[0...-1] + @product.images.first.ifoto.url(:big)) if @product.images.length > 0
          client.put_wall_post('Hello!', options)
        rescue
          @product.update_attribute :is_shared_on_facebook, false
        end
      end

      redirect_to order_stocks_path(current_vitrine.id)
    else
      render_wizard @product
    end
  end

  private

  def pet_params(step)
    permitted_attributes = case step
                           when 'first'
                             []

                           end
  end
end
