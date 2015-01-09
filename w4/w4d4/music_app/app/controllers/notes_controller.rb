class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.author = current_user

    if @note.save
      redirect_to @note.track, notice: "Successfully Created"
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to @note.track
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @track = @note.track
    if @note.author == current_user
      @note.destroy
      redirect_to @track, notice: "Successfully Removed"
    else
      render text: "Nice Try", status: 403
    end
  end

  private
    def note_params
      params.require(:note).permit(:track_note, :track_id)
    end
end
