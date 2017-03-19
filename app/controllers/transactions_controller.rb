class TransactionsController < ApplicationController

def show

  
user = transaction.user_id

@transaction = user.transactions.find(params[:id])
  

end

end
