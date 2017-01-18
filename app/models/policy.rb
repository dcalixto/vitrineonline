class Policy < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :vitrine_id
  # belongs_to :policyable, polymorphic: true

  

  has_many :shipman
  belongs_to :vitrine,  :inverse_of => :policy
  has_many :shippings, through: :shipman
  # has_many :policyable
  # has_many :products, through: :policyable

  attr_accessible :kind, :paypal, :guarantee, :shipping_ids

  validates :paypal, uniqueness: { case_sensitive: false },
                     length: { within: 1..70 }

#<D-d>accepts_nested_attributes_for :vitrine
 validates_presence_of :vitrine
end
