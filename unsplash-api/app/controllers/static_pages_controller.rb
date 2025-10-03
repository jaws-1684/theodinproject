class StaticPagesController < ApplicationController
	require "uri"
	require "net/http"
	require "json"

	def index
		@username = parse_url(params[:user_id])
		@photos = fetch_unsplash_photos(@username) if @username
	end

	
	def fetch_unsplash_photos(username)
		url = URI("https://api.unsplash.com/users/#{username}/photos?order_by=views&per_page=20")

		https = Net::HTTP.new(url.host, url.port)
		https.use_ssl = true

		request = Net::HTTP::Get.new(url)
		request["Authorization"] = "Client-ID #{ENV['UNSPLASH_ACCESS_KEY']}"

		response = https.request(request)
		parsed_response = JSON.parse(response.read_body)
		parsed_response.map { |item| item.dig('urls', 'regular') }.compact
	end

	def parse_url(url)
		url.split('@')[1] if url
	end
end
