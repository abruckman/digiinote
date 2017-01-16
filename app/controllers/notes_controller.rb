class NotesController < ApplicationController

  def index
  end

  def new
  end

  def create
    if request.xhr?
      picture = params[:picture]
      png     = Base64.decode64(picture['data:image/png;base64,'.length .. -1])
      
      prefix = 'photo_data'
      suffix = '.png'
      file = Tempfile.new [prefix, suffix], "#{Rails.root}/tmp", :encoding => 'ascii-8bit'
      file.write(png)
      file.rewind
      scanned = VISION.image(file.path).text

      
      file.close
      file.unlink
    else
      scanned = VISION.image(params[:picture]).text
    end
    
    text = scanned.text
    
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
