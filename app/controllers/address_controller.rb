class AddressController < ApplicationController


 def new
    @address_form = AddressForm.new(current_user)
  end

  def create
    @address_form = AddressForm.new(current_user)
    if @address_form.submit(params[:address_form])
      redirect_to carts_path, notice: 'Endereço Adicionado'

    else
      render 'new'
    end
  end

end
