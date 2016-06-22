class AddShareOptionsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_shared_on_facebook, :boolean, default: false
    add_column :products, :is_shared_on_twitter, :boolean, default: false
  end
end
