# require 'sidekiq'
class User < ActiveRecord::Base
  extend FriendlyId
  # include Sidekiq::Extensions

  friendly_id :name, use: [:slugged, :history]

  before_create :set_last_read_messages_at

  before_create { generate_token(:auth_token) }

  after_commit :send_user_welcome, on: :create
  #after_destroy { tire.update_index }


  has_one :vitrine, dependent: :destroy
  has_one :cart, dependent: :destroy
  # geocoded_by :address
  # after_validation :geocode, :if => :address_changed?

  has_many :orders, foreign_key: 'buyer_id'
  belongs_to :city, touch: true
  belongs_to :state, touch: true

  has_many :conversation_participants
  has_many :conversations,
           through: :conversation_participants

  has_many :feedbacks

  has_many :comments

  acts_as_voter
  acts_as_marker

  def full_name
    "#{name} #{surname}"
  end

  def user_address
    "#{address}"
  end

  def user_city
    "#{city.name}"
  end

  def user_state
    "#{state.code}"
  end

  def user_neighborhood
    "#{neighborhood}"
  end

  def user_postal_code
    "#{postal_code}"
  end

  def user_address_supplement
    "#{address_supplement}"
  end

  require 'file_size_validator'

  mount_uploader :avatar, AvatarUploader

  validates_format_of :postal_code, with: /\A(\d{5})([-]{0,1})(\d{3})\Z/, allow_blank: true

  validates :avatar,
            #:presence => true,
            file_size: {
              maximum: 1.megabytes.to_i
            }

  validates_format_of :postal_code, with: /\A(\d{5})([-]{0,1})(\d{3})\Z/, allow_blank: true

  #after_commit :flush_cache

  #def self.cached_find(id)
  #  Rails.cache.fetch([name, id], expires_in: 30.minutes) { find(id) }
   #end

  #def flush_cache
  #  Rails.cache.delete([self.class.name, id])
  #end

  accepts_nested_attributes_for :vitrine, allow_destroy: true

  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :name,
                  :surname,  :avatar, :avatar_id, :gender, :vitrine_attributes, :address, :state_id,
                  :city_id, :postal_code, :neighborhood, :address_supplement, :about

  has_secure_password

  validates_presence_of :email, :password, :name, :surname, :gender, on: :create

  validates :email, email: true,
                    uniqueness: { case_sensitive: false }

  validates :password, length: { within: 6..60 },
                       confirmation: true,
                       if: :is_password_validation_needed?

  validates :name, :surname, length: { within: 1..70 }

  validates :email, confirmation: true,
                    email: true,
                    on: :update

  def send_user_welcome
    UserMailer.delay_until(10.seconds.from_now, retry: false).user_welcome(self)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
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

  private

  def is_password_validation_needed?
    new_record? || password
  end
end
