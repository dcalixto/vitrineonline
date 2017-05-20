class Dispute < ActiveRecord::Base
  # attr_accessible :title, :body
  

  STATUSES = %w(open finished).freeze

  belongs_to :order
    belongs_to :seller, foreign_key: 'seller_id', class_name: 'Vitrine'
  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User' 

  
  
  
    attr_accessible :order_id,:seller_id,:buyer_id,:buyer_name,:seller_name,:transaction_id,:status,
:amount,:motive,:solution,:buyer_comment,:seller_comment,:buyer_email, :seller_email, :item_received
    mount_uploader :bf, BfUploader


after_create :send_dispute_confirmation, :status_open

def send_dispute_confirmation
 DisputeMailer.dispute_confirmation(self).deliver

end

#link_to 'Approve', request_path(request, request: {status: 'approved'}), method: put.
 validates :item_received,
            :presence => { :if => 'item_received.nil?' }


def status_open
    update_attribute :status, "open"
  end

  def statuts_finished!
    update_attribute :status, "finished"
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
