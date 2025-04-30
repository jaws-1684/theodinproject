class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, dependent: :destroy

  accepts_nested_attributes_for :passengers, reject_if: lambda { |attributes| attributes['name'].blank? || attributes['email'].blank? }
end
