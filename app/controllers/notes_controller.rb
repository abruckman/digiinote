class NotesController < ApplicationController
  include NotesHelper

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
          text = camera_reader(params[:picture])
          title = text[0..10]
        else
          text = VISION.image(params[:picture]).text.text
          title = params[:title]
        end

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
    if request.xhr?
      text = camera_reader(params[:picture])
    else
      picture = note_params[:picture]
      text = VISION.image(picture).text.text
      title = params[:title]
    end
    compiled_text = note_params[:text] + text
    @note.update(text: compiled_text)
    redirect_to "/notes/#{@note.id}/edit"
  end

  def get_camera
    @note = Note.find(session[:note_id])
    respond_to do |format|
      format.js { render "edit" }
      # format.html {}
    end
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
