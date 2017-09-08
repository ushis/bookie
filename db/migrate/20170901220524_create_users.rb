class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.index  :username, unique: true
      t.string :email,    null: false
      t.index  :email,    unique: true
      t.json   :auth_meta_data
      t.timestamps
    end
  end
end
