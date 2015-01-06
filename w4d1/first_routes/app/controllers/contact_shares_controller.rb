class ContactSharesController < ApplicationController

  def create
    contact_share = ContactShare.new(contact_share_params)
    if contact_share.save
      render json: contact_share
    else
      render json: contact_share.errors.full_messages, status: :unprocessable_entity
  end

  def destroy
    contact_share = ContactShare.find(params[:id])
    contact_share.destroy
    render json: {}
  end

  def favorite
    contact_share = ContactShare.find(params[:id])
    if contact_share.update(favorited: !contact_share.favorited)
      render json: contact_share
    else
      render json: contact_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

    def contact_share_params
      params[:contact_share].permit(:user_id, :contact_id)
    end
end