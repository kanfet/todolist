module LoginHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_in_via_browser(user)
    visit root_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end