require 'spec_helper'

describe "Users management", js: true do

  describe "Log in" do
    it "should log in user" do
      user = create(:user)
      visit root_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Log in"

      page.should have_content(user.username)
      current_path.should eq('/tasks')
    end
  end

  describe "Log out" do
    it "should log out user" do
      user = create(:user)
      log_in_via_browser(user)

      click_link user.username
      click_link "Log out"

      page.should have_no_content(user.username)
      current_path.should eq(root_path)
    end
  end

  describe "Sign up" do
    it "should sign up user and log in with it" do
      user = attributes_for(:user)
      visit root_path
      click_link "Sign up"
      expect{
        fill_in "Username", with: user[:username]
        fill_in "Password", with: user[:password]
        fill_in "Password confirmation", with: user[:password]
        click_button "Sign up"
        wait_until{ find("#logout") }
      }.to change(User, :count).by(1)

      page.should have_content(user[:username])
      current_path.should eq('/tasks')
    end
  end
end