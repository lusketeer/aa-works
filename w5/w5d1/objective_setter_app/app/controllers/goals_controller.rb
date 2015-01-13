class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  before_action :ensure_login
  def index
    completed ||= params[:completed]
    @goals = Goal.where(goal_type: "public")
    query_filter = completed.nil? ? "1 = 1" : "completed = '#{completed}'"
    @my_goals = current_user.goals.where(query_filter)
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user

    if @goal.save
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @comments = @goal.comments
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to goal_path(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def complete
    @goal = Goal.find(params[:id])
    @goal.complete!
    redirect_to goals_path
  end

  private
    def goal_params
      params.require(:goal).permit(:title, :goal_type, :completed)
    end

    def set_goal
      @goal ||= Goal.find(params[:id])
    end
end
