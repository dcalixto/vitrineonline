class CreateSbrands < ActiveRecord::Migration
  def change
    create_table :sbrands do |t|
 t.string :name
 t.timestamps
    end
  end
end
