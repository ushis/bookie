class CreateCovers < ActiveRecord::Migration[5.1]
  def change
    create_table :covers do |t|
      t.string :isbn, null: false
      t.index  :isbn, unique: true
      t.json   :image_meta_data
      t.timestamps
    end
  end
end
