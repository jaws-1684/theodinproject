class Kitten < ApplicationRecord
	validates :name, presence: true
	validates :age, presence: true

	require "pexels"

	def get_image(cuteness)
		client = Pexels::Client.new(ENV['PEXELS_API'])
		prompt = cuteness + ' cat'
		result = client.photos.search(prompt, per_page: 1).first
		result&.src["original"]
	end
end
