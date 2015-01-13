require 'spec_helper'

feature 'the signup process' do
  scenario "has a new user page" do
    visit new_user_path
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      user = FactoryGirl.build(:user)
      sign_up(user)
      expect(page).to have_content user.username
    end

    scenario "shows error messages" do
      visit new_user_path
      fill_in "password", with: "password"
      click_button "Sign Up"
      expect(page).to have_content "Username can't be blank"
    end
  end

  feature "signing in" do
    scenario "shows sign out button after sign in" do
      user = create(:user) do |user|
        user.goals.create(attributes_for(:public_goal))
      end
      sign_in(user)
      expect(page).to have_button "Sign Out"
      expect(page).to have_content "#{user.goals[0].title}"
    end
  end

  feature "signing out" do
    scenario "don't show sign out button after signed out" do
      user = FactoryGirl.create(:user)
      sign_in(user)
      click_button("Sign Out")
      expect(page).not_to have_button "Sign Out"
    end
  end
end
