# Returns the full title on a per-page basis.
def full_title(page_title)
	base_title = "Shooloo Learning"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}" 
	end
end

def sign_in(user)
  visit signin_path
  fill_in "Screen Name",    with: user.screen_name
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end