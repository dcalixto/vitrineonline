class TransactionsController < ApplicationController

def show
order = Order
  
@current_buyer = buyer.id
  
  @transaction = current_buyer.orders.transaction.find(params[:id]) 

end



end
