class ContactsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: (user.contacts + user.shared_contacts)
  end

  def create
    contact = Contact.new(contact_params)

    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: {}
  end

  def update
    contact = Contact.find(params[:id])

    if contact.update(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Contact.find(params[:id])
  end

  def favorite
    contact = Contact.find(params[:id])
    if contact.update(favorited: !contact.favorited)
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id, :favorited)
  end
end
