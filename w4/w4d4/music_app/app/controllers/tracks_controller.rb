class TracksController < ApplicationController
  before_action :require_login

  def show
    @track = Track.find(params[:id])
    @notes = @track.notes
    render :show
  end

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
    @albums = Album.all
    render :new
  end

  def edit
    @track = Track.find(params[:id])
    @track.album_id = params[:album_id]
    @albums = Album.all

    render :edit
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all

    if @track.save
      redirect_to @track, notice: 'Track was successfully created.'
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end

  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to @track, notice: 'Track was successfully updated.'
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy
    redirect_to @album, notice: 'Track was successfully destroyed.'
  end

  private
    def track_params
      params.require(:track).permit(:album_id, :name, :track_type, :lyrics)
    end
end
