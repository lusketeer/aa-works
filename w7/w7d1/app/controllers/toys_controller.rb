class ToysController < ApplicationController
  def show
    @toy = Toy.find(params[:id])
    render json: @toy
  end

  def update
    @toy = Toy.find(params[:id])
    if @toy.update(toy_params)
      render 'show'
    else
      render json: @toy.errors.full_messages, status: 422
    end
  end

  def destroy
    @toy = Toy.find(params[:id])
    @toy.destroy
    render json: @toy
  end
  
  private

  def toy_params
    params.require(:toy).permit(:happiness, :image_url, :name, :pokemon_id, :price)
  end
end
