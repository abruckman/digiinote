class NotesController < ApplicationController
  include NotesHelper
  

  def index
    p "breh" * 40
    render :index
  end

  def new
    p request.xhr?
    respond_to do |format|
      format.html {}
      format.js
    end
  end

  def create

    begin
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
    rescue Exception => e
      p "*"*50
      p e.message
      p "*"*50
      if e.message == "undefined method `text' for nil:NilClass"
        flash[:notice] = "No readable text in picture, try again with a new image"
      elsif e.message.include?("8:Insufficient tokens") || e.message.include?("14")
        flash[:notice] = "Google is tired, try again after a short break"
      else
        flash[:notice] = "#{e.message}; try again"
      end
      
      redirect_to notes_path
    end
  end


  def show
    @id = params[:id]
  end

  def edit
    @note = Note.find(session[:note_id])
  end

  def update
    begin
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
    rescue Exception => e
      p "*"*50
      p e.message
      p "*"*50
      if e.message == "undefined method `text' for nil:NilClass"
        flash[:notice] = "No readable text in picture, try again with a new image"
      elsif e.message.include?("8:Insufficient tokens") || e.message.include?("14")
        flash[:notice] = "Google is tired, try again after a short break"
      else
        flash[:notice] = "#{e.message}; try again"
      end
      
      redirect_to "/notes/#{@note.id}/edit"
    end
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
