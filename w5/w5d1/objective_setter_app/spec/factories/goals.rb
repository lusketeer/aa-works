require 'faker'
FactoryGirl.define do
  factory :public_goal, class: "Goal" do
    title Faker::Hacker.say_something_smart
    goal_type "public"
  end

  factory :private_goal, class: "Goal" do
    title Faker::Hacker.say_something_smart
    goal_type "private"
  end
end
