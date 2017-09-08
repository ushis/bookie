class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.belongs_to :user, null: false, index: true
      t.timestamps
    end
  end
end
