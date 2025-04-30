class FixAirportColumnNames < ActiveRecord::Migration[8.0]
  def change
    rename_column :airports, :airport_code, :code
    rename_column :airports, :city, :name

  end
end
