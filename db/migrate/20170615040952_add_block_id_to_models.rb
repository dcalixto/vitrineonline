class AddBlockIdToModels < ActiveRecord::Migration
  def change
    add_column :products, :block_id, :integer
    add_column :genders, :block_id, :integer
    add_column :categories, :block_id, :integer
    add_column :subcategories, :block_id, :integer
    add_column :eletronics, :block_id, :integer
    add_column :supplements, :block_id, :integer
    add_column :products, :eletronic_id, :integer
    add_column :products, :supplement_id, :integer
    add_column :products, :sport_id, :integer
    add_column :products, :auto_id, :integer
    add_column :products, :house_id, :integer
    add_column :products, :food_id, :integer
    add_column :products, :art_id, :integer
    add_column :products, :book_id, :integer
    add_column :products, :tool_id, :integer
    add_column :products, :virtual_id, :integer
 add_column :pdata, :block_id, :integer


add_column :pdata, :eletronic_id, :integer
add_column :pdata, :supplement_id, :integer
add_column :pdata, :sport_id, :integer

add_column :pdata, :auto_id, :integer


add_column :pdata, :house_id, :integer
add_column :pdata, :food_id, :integer

add_column :pdata, :art_id, :integer
add_column :pdata, :virtual_id, :integer








  end
end
