class TransactionsController < ApplicationController

def show

  

  @order = Order.find(params[:id])
    #@transaction = Transaction.find_by_id(params[:id])



  @transaction = current_user.transactions.find(params[:id])
  
end



end
