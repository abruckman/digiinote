require "googleauth"


class SessionsController < ApplicationController
	def new
		credentials = Google::Auth::UserRefreshCredentials.new(
		 client_id: ENV['OAUTH'],
		 client_secret: ENV['CLIENT_SECRET'],
		 scope: [
		   "https://www.googleapis.com/auth/drive",
		   "https://spreadsheets.google.com/feeds/",
		 ],
		 redirect_uri: "http://localhost:3000/oauth2callback")
		auth_url = credentials.authorization_uri
		
		# byebug
		redirect_to(auth_url.to_s)


	end


	def create
		credentials = Google::Auth::UserRefreshCredentials.new(
			client_id: ENV['OAUTH'],
			client_secret: ENV['CLIENT_SECRET'],
			scope: [
			  "https://www.googleapis.com/auth/drive",
			  "https://spreadsheets.google.com/feeds/",
			],
			redirect_uri: "http://localhost:3000/oauth2callback")
		credentials.code = params['code']
		credentials.fetch_access_token!
		@session = GoogleDrive::Session.from_credentials(credentials)
		p "-----" * 100
		p @session
		p "-----" * 100
		

		@files = @session.files
		redirect_to '/notes'
		 
	end

end
