class Policy < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :vitrine_id
  # belongs_to :policyable, polymorphic: true

  

  has_many :shipman
  belongs_to :vitrine,  :inverse_of => :policy
  has_many :shippings, through: :shipman
  # has_many :policyable
  # has_many :products, through: :policyable

  attr_accessible :kind, :paypal, :guarantee, :shipping_ids, :installment, :off,
    :pinstallment, :poff


  validates :paypal, uniqueness: { case_sensitive: false },
                     length: { within: 1..70 }


 validates_presence_of :vitrine





 before_update  :createcode
  

 def createcode
    if code.blank?
    self.code = rand(36**8).to_s(36)
    end
  end




end
