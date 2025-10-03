class PexelsService
	require "pexels"

	def get_image(cuteness)
		client = Pexels::Client.new(ENV['PEXELS_API'])
		result = client.photos.search(cuteness.concat('cat'), per_page: 1).first
		result&.src["original"]
	end
end


