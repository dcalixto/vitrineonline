class TransactionsController < ApplicationController

def show
# @transaction.user_id = @transaction.current_user.id 
@transaction = current_user.transactions.find(params[:id])
end
end
