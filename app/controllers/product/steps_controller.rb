# encoding: utf-8
class Product::StepsController < ApplicationController
  include Wicked::Wizard
  steps *Product.form_steps

  def show
    @product = Product.cached_find(params[:product_id])
    render_wizard 
 
  
  
  
  end

  def update
  #@product = Product.cached_find(params[:id])
@product = Product.cached_find(params[:product_id])
    
params[:product][:status] = 'active' if step == steps.last
      
    if @product.update_attributes(params[:product])
            #facebook sharing
      if @product.is_shared_on_facebook
        begin
          client = Koala::Facebook::API.new cookies[:facebook_auth_token]
          options = {
              :name => @product.name,
              :link => product_url(@product),
              :caption => "#{current_user.full_name} postou um produto",
              :description => @product.detail || ''
          }
          options[:picture] = (root_url[0...-1] + @product.images.first.ifoto.url(:big)) if @product.images.length > 0
          client.put_wall_post("#{@product.name}", options)
        rescue StandardError => e
          logger.error e.message
          @product.update_attribute :is_shared_on_facebook, false
        end
      end

      #twitter sharing
      if @product.is_shared_on_twitter
        begin
          client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV['TWITTER_API_KEY']
            config.consumer_secret     = ENV['TWITTER_API_SECRET']
            config.access_token        = cookies[:twitter_auth_token]
            config.access_token_secret = cookies[:twitter_auth_secret]
          end

          status = "Hello! I have added new product '#{@product.name}': #{product_url(@product)}"
          if @product.images.length > 0
            client.update_with_media status, File.new(@product.images.first.ifoto.path)
          else
            client.update status
          end
        rescue StandardError => e
          logger.error e.message
          @product.update_attribute :is_shared_on_twitter, false
        end
      end
      redirect_to(order_stocks_path(current_vitrine.id), :id => @product.id, name: params[:name])
     else
      render_wizard @product
    end
  end

 end
