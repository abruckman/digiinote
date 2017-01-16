

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
				# session[:access_token] = credentials.refresh_token
				session = GoogleDrive.login_with_oauth(credentials)
				p "-----to s" * 100
				# session[:authorization] = session1.authorization
				# p credentials.authorization
				# p session1.authorization
				@note = Note.last
				@document = session.upload_from_string(@note.text, title='FUCKATHIS', :content_type => "text/plain")

				# p "document -----------------"
				# p @documen



		redirect_to "/notes/#{@document.id}"

	end

end
