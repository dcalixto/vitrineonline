class CreateEletronics < ActiveRecord::Migration
  def change
    create_table :eletronics do |t|
      t.string :item
     t.string :slug 




      t.timestamps
    end
  end
end
