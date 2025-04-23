class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :location
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
