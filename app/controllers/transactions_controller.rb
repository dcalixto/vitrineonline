class TransactionsController < ApplicationController

def show

  @transaction = Transaction.find(params[:id])

if @transaction.user_id = @transaction.current_user.id 
@transaction = Transaction.find(params[:id])
  
else
   redirect_to :back   
   flash[:error] = 'Política Atualizada'
end
end
end
