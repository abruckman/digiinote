class NotesController < ApplicationController

  def index
  end

  def new
  end

  def create
    # if request.xhr?
    #   picture = params[:picture]['data:image/png;base64,'.length .. -1]
    # else
      picture = params[:picture]
        png      = Base64.decode64(picture['data:image/png;base64,'.length .. -1])
      # uri = URI::Data.new(picture)
      p '*'*20
      # p uri.data.encoding
      p '*'*20
      # file = Tempfile.new('foo')
      # file.write(uri.data)
      # file.rewind

      File.open("#{Rails.root}/public/uploads/somefilename.png", 'wb') do |f|
        f.write png
      end

  
    # end
    scanned = VISION.image("#{Rails.root}/public/uploads/somefilename.png").text
    # file.close
    # file.unlink
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
