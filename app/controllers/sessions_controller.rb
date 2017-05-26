

class SessionsController < ApplicationController
	helper SessionsHelper

	def save_google
		credentials = get_credentials

      auth_url = credentials.authorization_uri
      redirect_to(auth_url.to_s)
  end

  def create_callback
    credentials = get_credentials
    credentials.code = params['code']
    credentials.fetch_access_token!

    @note = Note.find(session[:note_id])

    session = GoogleDrive.login_with_oauth(credentials)
    @document = session.upload_from_string(@note.text, @note.title, :content_type => "text/plain")
    redirect_to "/notes/#{@document.id}"
  end


end
