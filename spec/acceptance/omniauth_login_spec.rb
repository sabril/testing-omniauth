require "spec_helper"
  
# Helper methods.
# I don't really recommend defining test helpers in the global scope.
# These are only put here so you can see them here, alongside the tests.

def logged_in?
  page.has_selector? "a", text: "Logout"
end

def login_with(provider, mock_options = nil)
  if mock_options == :invalid_credentials
    OmniAuth.config.mock_auth[provider] = :invalid_credentials
  elsif mock_options
    OmniAuth.config.add_mock provider, mock_options
  end

  visit "/auth/#{provider}"
end

# This is an example of logging into a website using OmniAuth using 
# the site's actual login links/buttons.
#
# If you're rigged your links/buttons to do magic, this may or may not work.
feature "Using Login Buttons" do

  background do
    visit root_path
    logged_in?.should == false
  end

  scenario "using OmniAuth Developer strategy" do
    OmniAuth.config.add_mock :developer, uid: "bob@smith.com", info: { name: "Bob" }
    click_on "Login as OmniAuth Developer"

    page.should have_content "Logged into developer as Bob (bob@smith.com)"
    logged_in?.should == true
  end

  scenario "using Facebook" do
    OmniAuth.config.add_mock :facebook, uid: "fb-12345", info: { name: "Bob Smith" }
    click_on "Login with Facebook"

    page.should have_content "Logged into facebook as Bob Smith (fb-12345)"
    logged_in?.should == true
  end

  scenario "using Twitter" do
    OmniAuth.config.add_mock :twitter, uid: "twitter-12345", info: { name: "Bob Smith" }
    click_on "Login with Twitter"

    page.should have_content "Logged into twitter as Bob Smith (twitter-12345)"
    logged_in?.should == true
  end

  scenario "invalid login" do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    click_on "Login with Twitter"

    page.should have_content "Login failed"
    logged_in?.should == false
  end
end

# This is an example of logging into a website using OmniAuth by bypassing the 
# site's real login links/buttons and directly visiting the /auth/:provider URL 
# (which redirects to /auth/:provider/callback with mocked credentials).
#
# This doesn't add code coverage to your site's actual login UI, but it puts you 
# into a logged in state (plus you don't have to visit the home page first to 
# find a button to click, which will save you 1 request per logged in spec).
feature "Logging in directly" do

  background do
    visit root_path
    logged_in?.should == false
  end

  scenario "using OmniAuth Developer strategy" do
    login_with :developer, uid: "bob@smith.com", info: { name: "Bob" }

    page.should have_content "Logged into developer as Bob (bob@smith.com)"
    logged_in?.should == true
  end

  scenario "using Facebook" do
    login_with :facebook, uid: "fb-12345", info: { name: "Bob Smith" }

    page.should have_content "Logged into facebook as Bob Smith (fb-12345)"
    logged_in?.should == true
  end

  scenario "using Twitter" do
    login_with :twitter, uid: "twitter-12345", info: { name: "Bob Smith" }

    page.should have_content "Logged into twitter as Bob Smith (twitter-12345)"
    logged_in?.should == true
  end

  scenario "invalid login" do
    login_with :twitter, :invalid_credentials

    page.should have_content "Login failed"
    logged_in?.should == false
  end

  scenario "valid login (without passing credentials)" do
    OmniAuth.config.add_mock :twitter, uid: "twitter-12345", info: { name: "Bob Smith" }
    login_with :twitter

    page.should have_content "Logged into twitter as Bob Smith (twitter-12345)"
    logged_in?.should == true
  end

  scenario "invalid login (without passing credentials)" do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    login_with :twitter

    page.should have_content "Login failed"
    logged_in?.should == false
  end
end
