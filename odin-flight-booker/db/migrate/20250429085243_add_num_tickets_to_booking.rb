class AddNumTicketsToBooking < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :num_tickets, :integer
  end
end
