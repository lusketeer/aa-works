class CatsController < ApplicationController
  #before_action :logged_in?
  before_action :own_cat?, only: [:edit, :update, :destroy]

  def index
    col = params[:order_by] || 'name'
    order = params[:order] || 'asc'

    @cats = Cat.all.order( col => order)
    render  :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user

    if @cat.save
      redirect_to @cat
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to @cat
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def cat_params
      params.require(:cat).permit(:name, :description, :sex, :birth_date, :color, :image_url)
    end

    def own_cat?
      cat = Cat.find(params[:id])
      unless cat.owner == current_user
        redirect_to cats_path
      end
    end
end
