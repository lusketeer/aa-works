class UserMailer < ApplicationMailer
  default from: "Albus Dumbledore <a.dumbledore@hogwarts.edu>"
  def activation_email(user)
    @user = user
    @activation_link = users_activate_url(activation_token: @user.activation_token, email: @user.email)
    mail(to: @user.email, subject: "Congratulations!")
  end
end
