class ChangesController < ApplicationController


def new
    @changes_form = ChangesForm.new(current_user)
  end

  def create
    @changes_form = ChangesForm.new(current_user)
    if @changes_form.submit(params[:changes_form])
      redirect_to carts_path, notice: 'Endereço Adicionado'

    else
      render 'new'
    end
  end

end
