class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :kind
       t.string :time
       t.string :option
      t.timestamps
    end
  end
end
