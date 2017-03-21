# encoding: utf-8
require 'product_recommender'
class CartsController < ApplicationController


  def add
    product = Product.find(params[:id])

    if product
      if product.buyable?(current_user)
        current_user.cart = Cart.new if current_user.cart.nil?
        condition = Condition.find_by_id(params[:condition_id])
        color = Color.find_by_id(params[:color_id])
        size = Size.find_by_id(params[:size_id])
        material = Material.find_by_id(params[:material_id])
        brand = Brand.find_by_id(params[:brand_id])

        quantity = params[:quantity].to_i > 0 ? params[:quantity].to_i : 1

        order = current_user.cart.orders.find_by_product_id_and_status_and_color_id_and_size_id(product.id, nil, color.nil? ? nil : color.id, size.nil? ? nil : size.id)


        if order.nil? # create new order

          order = Order.new
          order.product = product
          order.seller = product.vitrine
          order.buyer = current_user
          order.quantity = quantity
          order.color = color
          order.size = size         
          order.condition = product.condition
          order.material = product.material
          order.brand = product.brand
          current_user.cart.orders << order
        else # increase quantity
          order.quantity += quantity
          order.save
        end

        redirect_to product_path(product)
        flash[:success] = "#{product.name} adicionado(a) a sacola"

#  flash[:success] =   %Q[#{product.name} adicionado(a) a sacola <a href="/carts">ir para o carrinho</a>]

              else
        redirect_to product_path(product)
        flash[:error] = " Erro ao adicionar #{product.name} a sacola"

      end
    else
      redirect_to :vitrines, flash[:error] = 'Produto não existe'
    end




  end









  def index
    @user = current_user
    if current_user && current_user.cart
      @orders = current_user.cart.orders.where('status is null').paginate(per_page: 22, page: params[:page])

    end
    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)
  end

 # def user_address
 #   @user = current_user

 #   if @user.update_attributes(params[:user])
  #    redirect_to carts_path
  #    flash[:notice] = 'Conta atualiazada'
  #  else
   #   redirect_to carts_path
   #   flash[:error] = 'erro'
   # end
 # end



end




