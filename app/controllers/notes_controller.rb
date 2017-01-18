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
      if note_params[:picture]
        text = VISION.image(note_params[:picture]).text.text
      else
        text = ""
      end
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

  private
  def note_params
    params.require(:note).permit(:text, :title, :picture)
  end

end
