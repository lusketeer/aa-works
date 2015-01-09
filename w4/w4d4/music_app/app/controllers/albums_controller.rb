class AlbumsController < ApplicationController
  before_action :require_login

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
    render :show
  end

  def new
    @bands = Band.all
    @album = Album.new
    @album.band_id = params[:band_id]
    render :new
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    render :edit
  end

  def create
    @bands = Band.all
    @album = Album.new(album_params)

    if @album.save
      redirect_to @album, notice: 'Album was successfully created.'
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to @album, notice: 'Album was successfully updated.'
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    @album.destroy
    redirect_to @band, notice: 'Album was successfully destroyed.'
  end

  private
    def album_params
      params.require(:album).permit(:band_id, :name, :album_type)
    end
end
