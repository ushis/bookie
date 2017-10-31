class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :commentable, polymorphic: true, null: false, index: true
      t.belongs_to :author, index: true
      t.text       :comment
      t.timestamps
    end
  end
end
