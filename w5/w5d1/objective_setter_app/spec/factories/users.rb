require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password "password"
  end

  # factory :other_user do
  #   username Faker::Internet.user_name
  #   password "password"
  # end
end
