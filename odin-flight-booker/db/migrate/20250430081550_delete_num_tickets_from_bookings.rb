class DeleteNumTicketsFromBookings < ActiveRecord::Migration[8.0]
  def change
    remove_column :bookings, :num_tickets
  end
end
