class CreateEbrands < ActiveRecord::Migration
  def change
    create_table :ebrands do |t|
t.string :name
      t.timestamps
    end
  end
end
