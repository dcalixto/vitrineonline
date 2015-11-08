# encoding: utf-8
class PasswordResetsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by_email(params[:email])
      user.send_password_reset if user
      redirect_to action: :new
      flash[:success] = 'Verifique seu email. Enviamos o link para redefinir sua senha.'
    else
      flash.now[:error] = 'Email inválido ou não há nenhuma conta associada a esse email'
      render :new

    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def grats
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])

    if @user.password_reset_at < 2.hours.ago
      redirect_to new_password_reset_path
      flash[:alert] = 'O tempo para resetar o password expirou'

    elsif @user.update_attributes(params[:user])
      redirect_to action: :edit, controller: :password_resets
      flash[:success] = "Password alterado com sucesso, #{view_context.link_to('Clique aqui', login_path)} para entrar".html_safe

    else
      render :edit
    end
  end
end
