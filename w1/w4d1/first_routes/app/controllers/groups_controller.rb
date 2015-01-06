class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    render json: User.find(params[:user_id]).groups
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    render json: Group.find(params[:id]).contacts
  end

  # POST /groups
  # POST /groups.json
  def create
    group = Group.new(group_params)
    if group.save
      render json: group
    else
      render json: group.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    group = Group.find(params[:id])
    if group.update(group_params)
      render json: group
    else
      render json: group.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    group = Group.find(params[:id])
    group.destroy
    render json: {}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:user_id, :name)
    end
end
