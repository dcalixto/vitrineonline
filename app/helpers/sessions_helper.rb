# encoding: utf-8
module SessionsHelper
  def logado?
    !current_user.nil?
     end

  def deletar_user
    current_user = nil
    cookies.delete(:auth_token)
   end

  def logar(user)
    cookies.permanent[:auth_token] = user.auth_token
    # cookies[:auth_token] = {:value => user.auth_token, :expires => 3.month.from_now}
    current_user = user
  end
end
