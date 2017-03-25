class UsersWorker
  include Sidekiq::Worker

  #def perform(*args)
    # Do something
 # end

  def perform email
  #  UserMailer.signup_confirmation(@user).deliver_now	

  UserMailer.registration_confirmation(@user).deliver
  
  end
end
