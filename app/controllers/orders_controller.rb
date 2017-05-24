# encoding: utf-8
class OrdersController < ApplicationController
  skip_before_filter :authorize, only: :ipn_notification
  protect_from_forgery except: [:ipn_notification]

 cache_sweeper :order_sweeper


  def purchased
   
      
    if current_user.cart
      # @orders = current_user.cart.orders.where('status = ?', params[:status] || Order.statuses[0]).paginate(:per_page => 22, :page => params[:page])

      @q = current_user.cart.orders.where('status = ?', params[:status] || Order.statuses[0]).ransack(params[:q])
      #  @q = Order.joins(:user, :cart).where('status = ?', current_user.id, cart.id, params[:status] || Order.statuses[0]).ransack(params[:q])
      # @q = Order.where('buyer_id = ? and status = ?', current_user.id, params[:status] || Order.statuses[0]).ransack(params[:q])
      @orders = @q.result(distinct: true).paginate(page: params[:page], per_page: 22).order('created_at DESC')
    end

order = Order.find(params[:id])
dispute = order.dispute

  end

  def sold


    @q = Order.where('seller_id = ? and status = ?', current_vitrine.id, params[:status] || Order.statuses[0]).ransack(params[:q])
    
    
    @orders = @q.result(distinct: true).paginate(page: params[:page], per_page: 22).order('created_at DESC')


  end


  def checkout
    @order = current_user.cart.orders.find(params[:id])
    if current_user.address.blank?
      # redirect_to new_user_changes_path(current_user)
      redirect_to edit_user_path

      flash[:error] = 'Antes de prosseguir por favor, preencha o seu endereço'
    end
  end


  def track

    @current_seller = current_user.vitrine
    @order = current_seller.orders.find(params[:id])
    if current_seller.blank?
      # redirect_to new_user_changes_path(current_user)

      redirect_to "#{sold_orders_path}?status=#{Order.statuses[0]}"


      flash[:error] = 'Error'
    end
  end





  def track_done
    @order = Order.find(params[:id])
    if order.update_attributes(params[:order])
      flash =   { success: 'Número adicionado' }
    else
      flash =   { error: 'Erro' }
    end
    if request.xhr?
      render json: flash
    else
      redirect_to track_order_path(order), flash: flash
    end
  end




  def track_sent
    order = Order.find(params[:id])
    transaction = Transaction.find_by_id(params[:id])

    if order
      order.status = Order.statuses[1]
      order.transaction.update_attribute(:updated_at, Time.zone.now)

      order.save

  od = order.odata
  od.status = order.status
  od.save


      redirect_to "#{sold_orders_path}?status=#{Order.statuses[1]}",
      flash: { success: 'Estado Mudado' }
      OrderMailer.order_track(order).deliver 
    end
  end























  def confirmation
   
  #@order = Order.find(params[:id])
  
  end

  def update
    order = Order.find(params[:id])
   

    flash = if order.update_attributes(params[:order])


        od = order.odata
        od.shipping_cost = order.shipping_cost
        od.shipping_method  = order.shipping_method
          #od.pdata_id  = order.pdata_id

              od.save




              { success: 'Frete Salvo.' }


          



            else
              { error: 'Preço Inválido.' }
            end
    if request.xhr?
      render json: flash
    else
      redirect_to checkout_order_path(order), flash: flash
    end
  end

  def destroy
    if current_user.cart
      order = current_user.cart.orders.find(params[:id])
      order.destroy
      redirect_to carts_path
    end
  end







  def buy
    order = Order.find(params[:id])




    store_amount = (order.total_price * configatron.store_fee).round(2)
    seller_amount = (order.total_price - store_amount) + order.shipping_cost


    @api = PayPal::SDK::AdaptivePayments.new
    #byebug

    @pay = @api.build_pay({
      :actionType => "PAY",
      :cancelUrl => carts_url,
      :currencyCode => "BRL",
      # :feesPayer => "SENDER",
      :ipnNotificationUrl => ipn_notification_order_url(order), 

      :receiverList => {
        :receiver => [{
          :email =>  order.product.vitrine.policy.paypal,
          :amount => seller_amount,
          :primary => true

        },
        {
          :email => configatron.paypal.merchant,
          :amount => store_amount,
          :primary => false

        }]},
        :returnUrl => orders_confirmation_url






    })

    @response = @api.pay(@pay)
    #byebug
    # Access response
    if @response.success? && @response.payment_exec_status != "ERROR"
      @response.payKey
      redirect_to @api.payment_url(@response)  # Url to complete payment
    else
      @response.error[0].message
      redirect_to fail_order_path(order, error: @response.error[0].message)

    end
  end



  def fail
  end







  def ipn_notification
    logger.info("We've got an IPN!! raw_post object:")
    logger.info(request.raw_post)



    if PayPal::SDK::Core::API::IPN.valid?(request.raw_post)
      logger.info("IPN message: VERIFIED")
      order = Order.find(params[:id])
       product = order.product
     


      if order
        if params[:status] == 'COMPLETED'
          order.status = Order.statuses[0]
         # order.decrease_products_count
          product = order.product
          quantity = product.quantity
          product.quantity -= order.quantity
          product.save
          transaction = Transaction.new
          transaction.store_fee = order.store_fee
          transaction.user_id = order.buyer_id
          transaction.transaction_id = params[:transaction]['0']['.id_for_sender_txn']
          transaction.status = params[:status]
          order.transaction = transaction
                    order.save
         
        od = order.odata
      
        od.transaction_id = order.transaction.transaction_id
        od.status = order.status
         od.tcreated_at = order.transaction.created_at
        od.save
 



        


          OrderMailer.order_confirmation(order).deliver

        
  
 

        
        end
      end


    else
      logger.info("IPN message: VERIFICATION FAILED")
    end
    render nothing: true
  end


  def sent
    order = Order.find(params[:id])
    transaction = Transaction.find_by_id(params[:id])
    #  @orders = current_user.cart.orders.where('status = ?', params[:status] || Order.statuses[1]).paginate(:per_page => 22, :page => params[:page])
    @q = Order.where('status = ?', params[:status] || Order.statuses[1]).ransack(params[:q])
    @orders = @q.result(distinct: true).paginate(page: params[:page], per_page: 22).order('created_at DESC')

    if order
      order.status = Order.statuses[1]
      order.transaction.update_attribute(:updated_at, Time.zone.now)

      order.save
      redirect_to "#{sold_orders_path}?status=#{Order.statuses[0]}",
      flash: { success: 'Estado Mudado' }

    end
  end

  def index
  end

  def calculate_ship
    frete = Correios::Frete::Calculador.new :cep_origem => "23970-000",         # cep_origem: "#{@order.seller.post_code}",
      #:peso => "#{@order.product.weight}",
     # :comprimento =>  "#{@order.product.weight}",
     # :largura =>  "#{@order.product.weight}",
     # :altura =>  "#{@order.product.weight}",
   # cep_destino: params[:post_code]    #{params[:cep]}"
    cep_destino:   "#{params[:code]}"
           servicos = frete.calcular :sedex, :pac
    @pac = servicos[:pac].valor
    @sedex = servicos[:sedex].valor
   # render '/orders/:id/checkout'
    render :action => :calculate_ship

  end




end
