class CreateAvatars < ActiveRecord::Migration[5.1]
  def change
    create_table :avatars do |t|
      t.belongs_to :user, null: false, index: true
      t.json       :image_meta_data
      t.timestamps
    end
  end
end
