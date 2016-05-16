class Policy < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :vitrine_id
  # belongs_to :policyable, polymorphic: true

  

  has_many :shipman
  belongs_to :vitrine
  has_many :shippings, through: :shipman
  # has_many :policyable
  # has_many :products, through: :policyable

  attr_accessible :kind, :paypal, :guarantee, :shipping_ids

  validates :paypal, uniqueness: { case_sensitive: false },
                     length: { within: 1..70 }
end
