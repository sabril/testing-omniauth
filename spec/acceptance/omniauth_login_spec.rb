require "spec_helper"

feature "OmniAuth Login" do
  
  def logged_in?
    page.has_selector? "a", text: "Logout"
  end

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
