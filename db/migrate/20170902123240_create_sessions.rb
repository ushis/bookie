class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.belongs_to :user, null: false, index: true
      t.string     :ip_address, null: true
      t.string     :user_agent, null: true
      t.timestamps
    end
  end
end
