class Colorship < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :product_id, :order_id,  :product_data_id
  #
  belongs_to :product
  belongs_to :color
  belongs_to :order
  belongs_to :product_data


  






 


 


end
