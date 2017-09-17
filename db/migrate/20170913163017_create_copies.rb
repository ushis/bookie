class CreateCopies < ActiveRecord::Migration[5.1]
  def change
    create_table :copies do |t|
      t.belongs_to :book,  null: false, index: true
      t.belongs_to :owner, null: false, index: true
      t.index      [:book_id, :owner_id], unique: true
      t.timestamps
    end
  end
end
