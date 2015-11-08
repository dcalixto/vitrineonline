# encoding: utf-8
class ContactsController < ApplicationController
  def index
    @contact = Contact.new
    end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      redirect_to(action: 'index')
      flash[:notice] = "Obrigado por entrar em contato #{(@contact.name)}, o mais rapido possivel."
    else
      render :index
    end
  rescue ScriptError
    flash[:error] = 'Esta mensagem parece ser spam.'
  end
end
