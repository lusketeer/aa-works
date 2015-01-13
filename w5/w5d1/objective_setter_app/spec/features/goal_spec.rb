require 'spec_helper'

feature "goal model" do
  # before(:each) do
  #
  # end

  feature "see all goals" do
    scenario "should be logged in to see content" do
      # click_button "Sign Out"
      visit goals_path
      expect(page).to_not have_content "All Goals"
    end

    scenario "index page has a new goal button" do
      user2 = create(:user)
      sign_in(user2)
      expect(page).to have_link "Create New Goal"
    end

    scenario "index page shows everybody's public goal and all my goals" do

      user1 = create(:user) do |user|
        user.goals.create(attributes_for(:public_goal))
        user.goals.create(title: "ZZZZZZZ", goal_type: "private")
      end
      user2 = create(:user) do |user|
        user.goals.create(attributes_for(:public_goal))
      end
      sign_in(user2)
      # expect(page).to have_content "#{user2.username}"
      expect(page).to have_content "#{ user1.goals.first.title}"
      expect(page).not_to have_content "#{ user1.goals.last.title}"
      expect(page).to have_content "#{ user2.goals[0].title}"
    end
  end

  feature "create new goal" do
    scenario "create new goal shows the form" do
      user2 = create(:user)
      sign_in(user2)
      click_on "Create New Goal"
      expect(page).to have_content "New Goal"
    end

    scenario "create new goal actually creates a goal" do
      user2 = create(:user)
      sign_in(user2)
      visit new_goal_path
      fill_in "title", with: "Cook more"
      choose('private')
      click_button "Create Goal"
      expect(page).to have_content "Cook more"
    end
  end

  feature "edit goal" do
    scenario "should have edit link in show page" do
      user2 = create(:user) do |user|
        user.goals.create(attributes_for(:public_goal))
      end
      sign_in(user2)
      goal = user2.goals.first
      visit goal_path(goal)
      expect(page).to have_content goal.title
      expect(page).to have_link "Edit"
    end

    scenario "should be able to update" do
      user2 = create(:user) do |user|
        user.goals.create(attributes_for(:public_goal))
      end
      sign_in(user2)
      goal = user2.goals.first
      visit edit_goal_path(goal)
      expect(find("input[id=title]").value).to have_content "#{goal.title}"
      expect(find("input[checked=checked]").value).to have_content "#{goal.goal_type}"
      expect(page).to have_button "Update Goal"
    end
  end
end
