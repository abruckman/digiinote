class NotesController < ApplicationController
  def index
  end

  def new
  end

  def create
    scanned = VISION.image(params[:picture]).text
    "*" * 50
    p scanned.text
    "%" *50
    redirect_to '/notes'
  end
end
