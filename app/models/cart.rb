class Cart < ActiveRecord::Base
  belongs_to :user,  class_name: 'User', foreign_key: 'user_id' 
  has_many :orders 

  def subtotals
    orders.map(&:subtotal)
  end

  accepts_nested_attributes_for :user

  attr_accessor :address, :neighborhood, :postal_code, :address_supplement

  attr_accessible :user_attributes, :address, :neighborhood, :postal_code, :address_supplement

  # def user
  #    us = User.find_by_id(attributes['user_id'])
  #    end

  def user_address(user)
    user = current_user

    if user.update_attributes
      redirect_to carts_path

      flash[:notice] = 'Conta atualiazada'
    else
      redirect_to carts_path
      flash[:error] = 'erro'

    end
  end
end
