class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string  :isbn, null: false
      t.index   :isbn, unique: true
      t.string  :title
      t.index   :title
      t.string  :authors
      t.index   :authors
      t.timestamps
    end
  end
end
