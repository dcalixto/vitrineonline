class TransactionsController < ApplicationController

def show

  

  @order = Order.find(params[:id])
    @transaction = Transaction.find_by_id(params[:id])

end



end
