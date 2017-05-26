class Dispute < ActiveRecord::Base
  # attr_accessible :title, :body
  

  STATUSES = %w(open closed).freeze

  belongs_to :order
    belongs_to :seller, foreign_key: 'seller_id', class_name: 'Vitrine'
  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User' 
has_many :proofs
  
  
  
    attr_accessible :order_id,:seller_id,:buyer_id,:buyer_name,:seller_name,:transaction_id,:status,
:amount,:motive,:solution,:comment,:buyer_email, :seller_email, :item_received, :proofs_attributes
  
after_create :send_dispute_confirmation, :status_open

before_create ->{ proofs.build }



#after_update :send_update_seller



accepts_nested_attributes_for :proofs

def send_dispute_confirmation
 DisputeMailer.dispute_confirmation(self).deliver

end



#def send_confirmation_seller
# DisputeMailer.confirmation_seller(self).deliver

#end


#def send_update_seller
 #DisputeMailer.update_seller(self).deliver

#end




 acts_as_commentable

 validates :item_received,
            :presence => { :if => 'item_received.nil?' }


def status_open
    update_attribute :status, "open"
  end

 


def status_name
        status ? "open" : "closed"
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
