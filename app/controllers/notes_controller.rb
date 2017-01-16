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
          title = scanned[0..10]
        else
          scanned = VISION.image(params[:picture]).text
          title = params[:title]
        end


        text = scanned.text
        Note.create({text: text, title: title})
        credentials = Google::Auth::UserRefreshCredentials.new(
         client_id: ENV['OAUTH'],
         client_secret: ENV['CLIENT_SECRET'],
         scope: [
           "https://www.googleapis.com/auth/drive",
           "https://spreadsheets.google.com/feeds/",
         ],
         redirect_uri: BASE_URL )

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
