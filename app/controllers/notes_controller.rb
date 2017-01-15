class NotesController < ApplicationController
  def index
  end

  def new
  end

  def create
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
     redirect_uri: "http://localhost:3000/oauth2callback")
    auth_url = credentials.authorization_uri
    
    # byebug
    redirect_to(auth_url.to_s)    

    # redirect_to '/notes'
  end
end
