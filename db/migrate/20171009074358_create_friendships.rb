class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :friend, null: false, index: true
      t.index [:user_id, :friend_id], unique: true
      t.timestamps
    end
  end
end
