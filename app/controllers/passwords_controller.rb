# encoding: utf-8
class PasswordsController < ApplicationController
  def new
    @password_form = PasswordForm.new(current_user)
  end

  def create
    @password_form = PasswordForm.new(current_user)
    if @password_form.submit(params[:password_form])
      redirect_to :back, notice: 'Password Alterado com sucesso'

    else
      render 'new'
    end
  end
end
