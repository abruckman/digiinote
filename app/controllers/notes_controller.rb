class NotesController < ApplicationController

  def index
  end

  def new
    respond_to do |format|
      format.js
      # format.html {}
    end
  end

  def create

    # begin
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
          # byebug
          title = scanned.text[0..10]
        else
          p "*" * 50
          p params[:picture]
          p "*" * 50
          scanned = VISION.image(params[:picture]).text
          title = params[:title]
        end


        text = scanned.text

        @note = Note.create({text: text, title: title})
        session[:note_id] = @note.id

        redirect_to "/notes/#{@note.id}/edit"

        # byebug
    # rescue
    #   flash[:notice] = "Something went wrong, try again"
    #   redirect_to notes_path
    # end
    # redirect_to '/notes'
  end


  def show
    @id = params[:id]
  end

  def edit
    @note = Note.find(session[:note_id])
  end

  def update
    @note = Note.find(session[:note_id])
    picture = note_params[:picture]
    p "*" * 50
    p picture
    p "*" * 50    
    scanned = VISION.image(picture).text
    title = params[:title]
    text = note_params[:text] + scanned.text
 
    @note.update(text: text)
    redirect_to "/notes/#{@note.id}/edit"
  end

  def save_google
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
    @note = Note.find(session[:note_id])
    # session[:access_token] = credentials.refresh_token
    session = GoogleDrive.login_with_oauth(credentials)
    

    # session[:authorization] = session1.authorization
    # p credentials.authorization
    # p session1.authorization
    # @note = Note.last
    @document = session.upload_from_string(@note.text, @note.title, :content_type => "text/plain")

    # p "document -----------------"
    # p @documen

    redirect_to "/notes/#{@document.id}"

  end

  private
  def note_params
    params.require(:note).permit(:text, :title, :picture)
  end

end
