class AddFieldsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
    add_column :posts, :title, :string
    add_column :posts, :body, :text
  end
end
