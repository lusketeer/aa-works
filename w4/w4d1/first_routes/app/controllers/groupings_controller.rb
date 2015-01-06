class GroupingsController < ApplicationController
  def create
    grouping = Grouping.new(grouping_params)
    if grouping.save
      render json: grouping
    else
      render json: grouping.errors.full_messages, status: :unprocessable_entity
    end
  end
  def destroy
    grouping = Grouping.find(params[:id])
    grouping.destroy
    render json: {}
  end

  private
    def grouping_params
      params.require(:grouping).permit(:contact_id, :group_id)
    end
end
