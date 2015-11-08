class CreateColorsProducts < ActiveRecord::Migration
  def change
    create_table :colors_products, :id => false do |t|
      t.references :product
      t.references :color
    end
    add_index :colors_products, [:product_id, :color_id]
    add_index :colors_products, :product_id
  end
end
