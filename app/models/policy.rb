class Policy < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :vitrine_id
  #
  has_many :shipman
  belongs_to :vitrine
  has_many :shippings, through: :shipman

  attr_accessible :kind, :paypal, :guarantee, :shipping_ids

  validates :paypal, uniqueness: { case_sensitive: false },
                     length: { within: 1..70 }
end
