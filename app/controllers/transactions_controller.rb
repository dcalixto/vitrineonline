class TransactionsController < ApplicationController
  before_filter :authorize
  def index
    @transactions = current_vitrine.orders.transaction.where('status is not null')
    render :index
   end
end
