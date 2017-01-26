class Color < ActiveRecord::Base
  attr_accessible :name, :hex


  has_many :colorships
  has_one :colorship
   has_one :product_data
  has_many :products, :through => :colorships
  has_one :order, :through => :colorship
  accepts_nested_attributes_for :products, :order








  include Wicked::Wizard::Validations


  #returns the current step for the associated user
  def current_step
    product.current_step 
  end

  # returns the wizard steps for the User class
  def wizard_steps
    Product.wizard_steps
  end

  # Specify validations on Address which should apply when the user is on or past 
  # the address_details step
  def self.color_id_validations
    {

      color_id: {
        presence: {
          presence: true      }
      }
    }
  end




end
