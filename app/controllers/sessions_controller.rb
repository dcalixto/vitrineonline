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

      # if user.email_confirmed
      # logar user
      # redirect_to root_url
      #   if
      #  params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token

      #  else
      # redirect_to root_url

      # flash.now[:alert] = 'Antes de logar confirme seu email'
      #  cookies[:auth_token] = { value: user.auth_token, expires: 3.month.from_now, httponly: true, secure: !(Rails.env.test? || Rails.env.development?) }

      #  end

      redirect_to root_url # , :notice => "Logado!"
    else
      flash.now[:alert] = 'Email ou Password inválido'
      render :new

    end
  end

  def omniauth_callback
    auth_hash = request.env['omniauth.auth']

    user = User.find_by_uid(auth_hash[:uid])
    if user.nil? && auth_hash[:info][:email]
      user = User.find_by_email(auth_hash[:info][:email])
    end

    if user.nil?
      email_domain = ''
      email_domain = '@facebook.com' if auth_hash[:provider] == 'facebook'
      user = User.new(email: auth_hash[:info][:email] || auth_hash[:info][:nickname] + email_domain, name: auth_hash[:info][:first_name] || '', surname: auth_hash[:info][:last_name] || '', gender: 'I')
      user.password_digest = ''
      user.save!(validate: false)
    end

    user.update_attribute(:login_at, Time.zone.now)
    user.update_attribute(:ip_address, request.remote_ip)
    user.update_attribute(:provider, auth_hash[:provider])
    user.update_attribute(:uid, auth_hash[:uid])
    user.update_attribute(:oauth_token, auth_hash[:credentials][:token])
    user.update_attribute(:oauth_expires_at, Time.at(auth_hash[:credentials][:expires_at]))

    cookies[:auth_token] = { value: user.oauth_token, expires: user.oauth_expires_at, secure: !(Rails.env.test? || Rails.env.development?) }
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
