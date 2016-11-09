# encoding: utf-8
class OrdersController < ApplicationController
  #skip_before_filter :authorize, only: :ipn_notification
 # protect_from_forgery except: [:ipn_notification]

  def purchased
    if current_user.cart
      # @orders = current_user.cart.orders.where('status = ?', params[:status] || Order.statuses[0]).paginate(:per_page => 22, :page => params[:page])
      @q = current_user.cart.orders.where('status = ?', params[:status] || Order.statuses[0]).ransack(params[:q])
      #  @q = Order.joins(:user, :cart).where('status = ?', current_user.id, cart.id, params[:status] || Order.statuses[0]).ransack(params[:q])
      # @q = Order.where('buyer_id = ? and status = ?', current_user.id, params[:status] || Order.statuses[0]).ransack(params[:q])
      @orders = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
    end
  end

  def sold
    # @orders = Order.where('seller_id = ? and status = ?', current_vitrine.id, params[:status] || Order.statuses[0]).paginate(:per_page => 2, :page => params[:page]).order('created_at DESC')
    @q = Order.where('seller_id = ? and status = ?', current_vitrine.id, params[:status] || Order.statuses[0]).ransack(params[:q])
    @orders = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
  end

  def checkout
    @order = current_user.cart.orders.find(params[:id])
    if current_user.address.blank?
      redirect_to :back
      flash[:error] = 'Antes de prosseguir por favor, preencha o seu endereço'
    end
  end

  def update
    order = Order.find(params[:id])
    flash = if order.update_attributes(params[:order])
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
    #store_amount = (order.total_price * configatron.store_fee).round(2)
    #seller_amount = (order.total_price - store_amount) + order.shipping_cost


   @api = PayPal::SDK::AdaptivePayments.new



   


      @pay = @api.build_pay({
        :actionType => "PAY",
        :cancelUrl => carts_url,
        :currencyCode => "BRL",
        :feesPayer => "SENDER",
        :ipnNotificationUrl => ipn_notification_order_url(order),

        :receiverList => {
          :receiver => [{
           # :email =>  order.product.vitrine.policy.paypal,
            :email =>  "calixtomariaa@gmail.com",

           # :amount => seller_amount,
            :amount => "50",

            :primary => true},
            {#:email => configatron.paypal.merchant,
            :email => "admin@vitrineonline.com",

             :amount => store_amount, 
             
             :amount => "60", 
             :primary => false}]},
             :returnUrl => carts_url })


 begin

             @response = @api.pay(@pay)

             # Access response
             if @response.success? && @response.payment_exec_status != "ERROR"
               @response.payKey
              redirect_to @api.payment_url(@response)  # Url to complete payment
             else
               @response.error[0].message
               redirect_to fail_order_path(order)

             end
  end
 end


  
  def fail
  end

  def ipn_notification
    ipn = PayPal::SDK::Core::API::IPN.new
    
    ipn.send_back(request.raw_post)


 if PayPal::SDK::Core::API::IPN.valid?(request.raw_post)
      logger.info("IPN message: VERIFIED")


   # if ipn.verified?
      order = Order.find(params[:id])
      if order
        if params[:status] == 'COMPLETED'
          order.status = Order.statuses[0]
          order.decrease_products_count
          transaction = Transaction.new
          transaction.store_fee = order.store_fee
          transaction.transaction_id = params[:transaction]['0']['.id_for_sender_txn']
          transaction.status = params[:status]
          order.transaction = transaction
          order.save

        end
      end
    end

    render nothing: true
  end



  def sent
    order = Order.find(params[:id])
    transaction = Transaction.find_by_id(params[:id])
    #  @orders = current_user.cart.orders.where('status = ?', params[:status] || Order.statuses[1]).paginate(:per_page => 22, :page => params[:page])
    @q = Order.where('status = ?', params[:status] || Order.statuses[1]).ransack(params[:q])
    @orders = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)

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
    frete = Correios::Frete::Calculador.new cep_origem: '23970-000',
      cep_destino: params[:post_code]
    servicos = frete.calcular :sedex, :pac
    @pac = servicos[:pac].valor
    @sedex = servicos[:sedex].valor
    render '/path/to/rails/app//orders/:id/checkout'
  end
end
