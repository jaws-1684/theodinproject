class FixPassengerBookingRelationship < ActiveRecord::Migration[8.0]
  def change
    remove_reference :bookings, :passenger, foreign_key: true, index: false
    remove_column :bookings, :passenger_id
  end
end
