class CreateConversationParticipants < ActiveRecord::Migration
  def change
    create_table :conversation_participants do |t|
      t.boolean  :has_read,        :default => false
      t.integer  :user_id#,          :null => false
      t.integer  :conversation_id#,  :null => false
      t.timestamps
    end
     add_index :conversation_participants, :user_id
    add_index :conversation_participants, :conversation_id
  end
end
