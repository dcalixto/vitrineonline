# encoding: utf-8
require 'product_recommender'
class CartsController < ApplicationController
 # def add
   # product = Product.find(params[:id])

   # if product
     # if product.buyable?(current_user)
      #  current_user.cart = Cart.new if current_user.cart.nil?
      #  color = Color.find_by_id(params[:color_id])
      #  size = Size.find_by_id(params[:size_id])
      #  condition = Condition.find_by_id(params[:condition_id])
      #  gender = Gender.find_by_id(params[:gender_id])
       # category = Category.find_by_id(params[:category_id])
       # subcategory = Subcategory.find_by_id(params[:subcategory_id])
      #  material = Material.find_by_id(params[:material_id])
      #  quantity = params[:quantity].to_i > 0 ? params[:quantity].to_i : 1
      #  order = current_user.cart.orders.find_by_product_id_and_status_and_color_id_and_size_id(product.id, nil, color.nil? ? nil : color.id, size.nil? ? nil : size.id)

       # if order.nil? # create new order
        #  order = Order.new
        #  order.product = product
        #  order.seller = product.vitrine
        #  order.buyer = current_user
        #  order.quantity = quantity
        #  order.color = color
        #  order.size = size

        #  order.condition = condition
        #  order.gender = gender
        #  order.category = category
        #  order.subcategory = subcategory
        #  order.material = material

       #   current_user.cart.orders << order
       # else # increase quantity
        #  order.quantity += quantity
        #  order.save
       # end

       # redirect_to product_path(product)
        #flash[:success] = "#{product.name} adicionado(a) a sacola"
    #  else
       # redirect_to product_path(product)
     #   flash[:error] = " Erro ao adicionar #{product.name} a sacola"

    #  end
   # else
     # redirect_to :vitrines, flash[:error] = 'Produto não existe'
   # end
 # end




def add
    product = Product.find(params[:id])

    if product
      if product.buyable?(current_user)
        current_user.cart = Cart.new if current_user.cart.nil?

        order = current_user.cart.orders.find_by_product_id_and_status(product.id, nil)


        if order.nil? # create new order
          order = Order.new
          order.product = product
          order.seller = product.vitrine
          order.buyer = current_user
          order.quantity = 1
          current_user.cart.orders << order
        else # increase quantity
          order.quantity = order.quantity.succ
          order.save
        end

        redirect_to product_path(product)
        flash[:success] = "#{(product.name)} adicionado(a) a sacola"
      else
        redirect_to product_path(product)
        flash[:error] = " Erro ao adiocionar #{(product.name)} a sacola"

      end
    else
      redirect_to :vitrines, flash[:error] = "Produto não existe"
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

  def user_address
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to carts_path
      flash[:notice] = 'Conta atualiazada'
    else
      redirect_to carts_path
      flash[:error] = 'erro'
     end
  end
end


