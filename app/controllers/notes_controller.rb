class NotesController < ApplicationController
  def index
  end

  def new
  end

  def show
    @id = params[:id]
  end

  def create
   

    begin
        scanned = VISION.image(params[:picture]).text
        "*" * 50
        text = scanned.text
        p "%" *50
        Note.create({text: text})
        credentials = Google::Auth::UserRefreshCredentials.new(
         client_id: ENV['OAUTH'],
         client_secret: ENV['CLIENT_SECRET'],
         scope: [
           "https://www.googleapis.com/auth/drive",
           "https://spreadsheets.google.com/feeds/",
         ],
         redirect_uri: "https://evening-lake-82966.herokuapp.com/oauth2callback")
        auth_url = credentials.authorization_uri
        redirect_to(auth_url.to_s)


        # byebug
    rescue
      flash[:notice] = "Something went wrong, try again"
      redirect_to notes_path
    end
    # redirect_to '/notes'
  end
end
