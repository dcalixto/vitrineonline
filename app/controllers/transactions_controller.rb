class TransactionsController < ApplicationController

def show

  

  @order = Order.find(params[:id])
    #@transaction = Transaction.find_by_id(params[:id])



  @transacion = current_user.transacions.find(params[:id])
  
end



end
