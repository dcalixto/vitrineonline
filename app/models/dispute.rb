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

accepts_nested_attributes_for :proofs

def send_dispute_confirmation
 DisputeMailer.dispute_confirmation(self).deliver

end


 acts_as_commentable

#link_to 'Approve', request_path(request, request: {status: 'approved'}), method: put.
 validates :item_received,
            :presence => { :if => 'item_received.nil?' }


def status_open
    update_attribute :status, "open"
  end

 
#link_to (@problem.status ? "Yes" : "No"), flop_problem_path(@problem)

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


#   private

#  def images_build
  #  build_policy
 #   images.build

  #  true
 # end

end
