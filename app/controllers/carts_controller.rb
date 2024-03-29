# encoding: utf-8
require 'product_recommender'
class CartsController < ApplicationController


  def add
    product = Product.find(params[:id])
    # pdata = Pdata.find_by_id(params[:id])

    if product
      if product.buyable?(current_user)
        current_user.cart = Cart.new if current_user.cart.nil?
        condition = Condition.find_by_id(params[:condition_id])
        color = Color.find_by_id(params[:color_id])
        size = Size.find_by_id(params[:size_id])
        material = Material.find_by_id(params[:material_id])
       

        quantity = params[:quantity].to_i > 0 ? params[:quantity].to_i : 1

        order = current_user.cart.orders.find_by_product_id_and_status_and_color_id_and_size_id(product.id, nil, color.nil? ? nil : color.id, size.nil? ? nil : size.id)


        if order.nil? # create new order

          order = Order.new
          order.product = product

          order.seller = product.vitrine
          order.seller_name = product.vitrine.name
          order.buyer = current_user
          order.buyer_name = current_user.first_name
          order.quantity = quantity
          order.color = color
          order.size = size         
          order.condition = product.condition
          order.material = product.material
        

          current_user.cart.orders << order


        else # increase quantity
          order.quantity += quantity
          order.save

        end
        #@pdata = Pdata.find_by_id(params[:id])

        od = Odata.new
        #od.pdata = @pdata

        od.cart_id = order.cart_id
        od.order_id = order.id
        od.product_id = order.product_id
        od.quantity = order.quantity
        od.seller_name = order.seller_name
        od.buyer_name = order.buyer_name
        od.buyer_id = order.buyer_id
        od.seller_id = order.seller_id
        od.color_id = order.color_id
        od.size_id = order.size_id
       
        od.condition_id = order.condition_id
        od.pdata_id  = order.pdata_id
        od.user_address = order.buyer.address
        od.user_neighborhood = order.buyer.neighborhood
        od.user_city = order.buyer.city
        od.user_state = order.buyer.state
        od.user_postal_code =  order.buyer.postal_code

        od.vitrine_address = order.seller.address
        od.vitrine_neighborhood = order.seller.neighborhood
        od.vitrine_city = order.seller.city
        od.vitrine_state = order.seller.state
        od.vitrine_postal_code =  order.seller.postal_code

        od.save


        redirect_to product_path(product)
        flash[:success] = "#{product.name} adicionado(a) a sacola"

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



end




