class Dispute < ActiveRecord::Base
  # attr_accessible :title, :body
  

  STATUSES = %w(open finished).freeze

  belongs_to :order
    belongs_to :seller, foreign_key: 'seller_id', class_name: 'Vitrine'
  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User' 
has_many :images
  
  
  
    attr_accessible :order_id,:seller_id,:buyer_id,:buyer_name,:seller_name,:transaction_id,:status,
:amount,:motive,:solution,:buyer_comment,:seller_comment,:buyer_email, :seller_email


  def build_default_models
      #  build_policy
      images.build

      true
    end


  STATUSES.each do |method|
    define_method "#{method}?" do
      status == method
    end
  end

  def self.statuses
    STATUSES
  end
end
