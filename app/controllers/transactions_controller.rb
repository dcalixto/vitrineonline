class TransactionsController < ApplicationController

def show

  
@current_user = current_user
  @transaction = current_user.transactions.find(params[:id])
  
end



end
