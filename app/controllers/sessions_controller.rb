# encoding: utf-8
class SessionsController < ApplicationController
  def new
    redirect_to root_url if current_user
  end


  def create

    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      user.update_attribute(:login_at, Time.zone.now)
      user.update_attribute(:ip_address, request.remote_ip)
      if user.email_confirmed
       # params[:remember_me]
      #  cookies.permanent[:auth_token] = { :value => user.auth_token, httponly: true, :expires => 1.year.from_now} 
        logar
        redirect_to root_url
      else
         flash.now[:alert] = "Primeiramente ative sua conta, verifique seu email com nosso email de confirmação"
 render :new

      #  cookies[:auth_token] = { :value => user.auth_token, httponly: true, :expires => 1.year.from_now}
 

      end
     # redirect_to root_url #, :notice => "Logado!"
    else
      flash.now[:alert] = "Email,  Password inválido ou conta inativa"
      render :new
    end
  end


 
  def create
      user = User.find_by_email(params[:email].downcase)
      if user && user.authenticate(params[:password])
      if user.email_confirmed
          sign_in user
        redirect_back_or user
      else
        flash.now[:error] = 'Please activate your account by following the 
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
      else
        flash.now[:error] = 'Invalid email/password combination' # Not quite right!
        render 'new'
      end
  end





  def omniauth_callback
    auth_hash = request.env['omniauth.auth']

    # twitter auth used for product sharing only
   if auth_hash[:provider] == 'twitter'
      cookies['twitter_auth_token'] = { value: auth_hash[:credentials][:token]}
      cookies['twitter_auth_secret'] = { value: auth_hash[:credentials][:secret]}
      render :text => '<script type="text/javascript">window.close();</script>'
      return
    end


    user = User.find_by_uid(auth_hash[:uid])
    if user.nil? && auth_hash[:info][:email]
      user = User.find_by_email(auth_hash[:info][:email])
    end

    if user.nil?
      email_domain = ''
      email_domain = '@facebook.com' if auth_hash[:provider] == 'facebook'
      user = User.new(email: auth_hash[:info][:email] || auth_hash[:info][:nickname] + email_domain, first_name: auth_hash[:info][:first_name] || '', last_name: auth_hash[:info][:last_name] || '',  address: auth_hash[:extra][:location] || '', gender: 'I')
      
      user.password_digest = ''
      user.save!(validate: false)
    end

    user.update_attribute(:login_at, Time.zone.now)

    user.update_attribute(:ip_address, request.remote_ip)
    user.update_attribute(:provider, auth_hash[:provider])
    user.update_attribute(:uid, auth_hash[:uid])
    user.update_attribute(:oauth_token, auth_hash[:credentials][:token])
    user.update_attribute(:oauth_expires_at, Time.at(auth_hash[:credentials][:expires_at]))

    cookies[:auth_token] = { value: user.oauth_token, expires: user.oauth_expires_at}
    redirect_to root_url
  end



  def facebook
     @facebook ||= Koala::Facebook::API.new(oauth_token)
     block_given? ? yield(@facebook) : @facebook
   rescue Koala::Facebook::APIError => e
     logger.info e.to_s
     nil
   end


  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
    current_user = nil
  end
end
