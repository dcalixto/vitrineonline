class AddFreeshipToProduct < ActiveRecord::Migration
  def change
    add_column :products, :freeship, :boolean,  :default => false
  end
end
