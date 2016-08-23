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
   cookies[:auth_token] = {:value => user.auth_token, :expires => Time.now + 3600, httponly: true,secure: true}

    current_user = user
     end
   #
end
