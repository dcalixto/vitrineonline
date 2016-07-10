class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text     :body,                        :null => false
      t.integer  :conversation_id,             :null => false
      t.integer  :conversation_participant_id, :null => false
      t.timestamps
    end
       add_index :messages, :conversation_id
    add_index :messages, :conversation_participant_id
  end
end
