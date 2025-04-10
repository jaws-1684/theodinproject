class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, index: { unique: true, name: "unique_usernames" }
      t.timestamps
    end
  end
end
