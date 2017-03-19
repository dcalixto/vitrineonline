class TransactionsController < ApplicationController

def show

  
@current_user = current_user
  @transaction = curent_user.transactions.find(params[:id])
  
end



end
