class NotesController < ApplicationController

  def index
  end

  def new
    respond_to do |format|
      format.js
      # format.html {}
    end
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
        p text
        p "8"*50
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

  def create_callback
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: ENV['OAUTH'],
      client_secret: ENV['CLIENT_SECRET'],
      scope: [
        "https://www.googleapis.com/auth/drive",
        "https://spreadsheets.google.com/feeds/",
      ],
      redirect_uri: BASE_URL )
    credentials.code = params['code']
    credentials.fetch_access_token!
    # session[:access_token] = credentials.refresh_token
    session = GoogleDrive.login_with_oauth(credentials)
    p "-----to s" * 100
    # session[:authorization] = session1.authorization
    # p credentials.authorization
    # p session1.authorization
    @note = Note.last
    @document = session.upload_from_string(@note.text, @note.title, :content_type => "text/plain")

    # p "document -----------------"
    # p @documen

    redirect_to "/notes/#{@document.id}"

  end
end
