class TransactionsController < ApplicationController

def show

  
#@current_user = current_user
  #@transaction = current_user.transactions.find(params[:id])
  

 @transaction =  Transaction.where(user_id: user.id, order_id: order.id)
end



end
