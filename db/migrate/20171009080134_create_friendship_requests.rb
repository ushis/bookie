class CreateFriendshipRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friendship_requests do |t|
      t.belongs_to :sender, null: false, index: true
      t.belongs_to :receiver, null: false, index: true
      t.index [:sender_id, :receiver_id], unique: true
      t.string :state, null: false
      t.index [:sender_id, :state]
      t.index [:receiver_id, :state]
      t.timestamps
    end
  end
end
