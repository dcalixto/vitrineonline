
# require File.join File.dirname(__FILE__), 'send_code'
class User < ActiveRecord::Base
  extend FriendlyId

  friendly_id :first_name, use: [:slugged, :history]

  before_create :set_last_read_messages_at

  before_create { generate_token(:auth_token) }
 #after_commit :send_user_welcome, :on => :create
 ##before_create :confirmation_token

after_commit  :confirmation_token, :on => :create
  has_one :vitrine, dependent: :destroy, :inverse_of => :user


  has_one :cart, dependent: :destroy

  has_many :orders, foreign_key: 'buyer_id',  dependent: :destroy
  has_many :transactions
  belongs_to :city, touch: true
  belongs_to :state, touch: true

  has_many :conversation_participants
  has_many :conversations,
           through: :conversation_participants

  has_many :feedbacks, :inverse_of => :user

  has_many :probacks, :inverse_of => :user
  has_many :comments

  # TODO: MAKE REPORTS
  # has_many :reports                 # Allow user to report others
  # has_many :reports, as: :reportable # Allow user to be reported as well

  # has_one_time_password

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      # populate your model

      obj.city.name = geo.city
      obj.state.code = geo.state_code
      obj.postal_code = geo.postal_code
         end
  end

  #  def online?
  #  $redis_onlines.exists( self.id )
  #  end

  def online?
    updated_at > 5.minutes.ago
  end

  scope :online, -> { where('updated_at > ?', 5.minutes.ago) }



acts_as_voter


  after_validation :fetch_address

  after_commit :flush_cache


   before_create  :create_code


  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_user
    User.cached_find(user_id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_address
    address.to_s
  end

  def user_city
    city.name.to_s
  end

  def user_state
    state.code.to_s
  end

  def user_neighborhood
    neighborhood.to_s
  end

  def user_postal_code
    postal_code.to_s
  end

  def user_address_supplement
    address_supplement.to_s
  end

  mount_uploader :avatar, AvatarUploader
 

  validates_format_of :postal_code, with: /\A(\d{5})([-]{0,1})(\d{3})\Z/, allow_blank: true

  accepts_nested_attributes_for :vitrine, allow_destroy: true

  attr_accessible :email, :confirm_token, :email_confirmation, :email_confirmed, :password, :password_confirmation, :first_name,
                  :last_name, :avatar, :avatar_id, :gender, :vitrine_attributes, :address, :state_id,
                  :city_id, :postal_code, :neighborhood, :address_supplement, :about, :phone

  has_secure_password

  validates_presence_of :email, :password, :first_name, :last_name, :gender, on: :create

  validates :email, email: true,
                    uniqueness: { case_sensitive: false }

  validates :password, length: { within: 6..60 },
                       format: { with: /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/, message: "Deve ter pelo menos 6 caracteres e incluir um número e uma letra" },
                       confirmation: true,
                       if: :is_password_validation_needed?

  validates :first_name, :last_name, length: { within: 1..70 }

  validates :email, confirmation: true,
                    email: true,
                    on: :update

  # Two Factor Authentication

  # def authenticate(email, password)
  #  if email.eql?(self.email) && password.eql?(self.password)
  #      send_auth_code
  #  end
  #  end

  #  def send_auth_code
  #    SendCode.new.send_sms(:to => self.phone, :body => "Codigo #{self.otp_code}")
  #  end

 # def send_user_welcome
 #   UserMailer.user_welcome(self).deliver
 # end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end


 def send_password_change
    self.password_change_at = Time.zone.now
    save!
    UserMailer.password_change(self).deliver
  end


  def last_read_messages_at
    if read_attribute(:last_read_messages_at).nil?
      created_at
    else
      read_attribute(:last_read_messages_at)
    end
  end

  def active_conversations
    conversations
  end

  def set_last_read_messages_at
    write_attribute(:last_read_messages_at, DateTime.now)
  end

  def unread_messages?
    !conversations.where(['conversations.updated_at > ?', last_read_messages_at]).empty?
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
   # send_user_welcome
    save!(validate: false)
    end


   def create_code
    if code.blank?

    self.code = rand(36**8).to_s(36)
    end
  end



  private

  def is_password_validation_needed?
    new_record? || password
  end

  def confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
end
end
