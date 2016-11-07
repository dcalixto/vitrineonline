# encoding: utf-8
class OrdersController < ApplicationController
  skip_before_filter :authorize, only: :ipn_notification
  protect_from_forgery except: [:ipn_notification]

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
 

    
    pay_request = HTTParty.post('https://svcs.paypal.com/AdaptivePayments/Pay',
  :body =>
    {:actionType => "PAY",
     :currencyCode => "BRL",
     :receiverList => {
       :receiver => [
          { :email => order.product.vitrine.policy.paypal, 'amount' => seller_amount, 'primary' => true },
          { :email => configatron.paypal.merchant, 'amount' => store_amount, 'primary' => false }

        ]
      },
      :memo => order.product.name,
      :feesPayer => 'SENDER',
      :ipnNotificationUrl => ipn_notification_order_url(order),

     :returnUrl =>  carts_url,
     :cancelUrl =>  carts_url,
     :requestEnvelope => {
       :errorLanguage => "pt_BR",
       :detailLevel => "ReturnAll"}
     },
     :headers => {
       "X-PAYPAL-SECURITY-USERID" => "admin_api1.vitrineonline.com",
       "X-PAYPAL-SECURITY-PASSWORD" => "8CYZME3C4YAEJVD2",
       "X-PAYPAL-SECURITY-SIGNATURE" => "AFcWxV21C7fd0v3bYYYRCpSSRl31Ak0xPIy-QieczmS5X.b6k8jLOC8A",
       "X-PAYPAL-APPLICATION-ID" => "APP-8TU98166249274123",
       "X-PAYPAL-REQUEST-DATA-FORMAT" => "JSON",
       "X-PAYPAL-RESPONSE-DATA-FORMAT" => "JSON"
     }
 )
    




  pay_response = pay_request.pay(data)

    if pay_response.success?
      redirect_to pay_response.approve_paypal_payment_url
    else
      logger.info pay_response
      redirect_to fail_order_path(order)
    end

    
    
  
  end

  def fail
  end

  def ipn_notification
    ipn = PaypalAdaptive::IpnNotification.new
    ipn.send_back(request.raw_post)

    if ipn.verified?
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
