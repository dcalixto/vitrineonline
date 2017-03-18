class TransactionsController < ApplicationController

def show
order = Order
  

  
  @transaction = current_user.orders.transaction.find(params[:id]) 

end



end
