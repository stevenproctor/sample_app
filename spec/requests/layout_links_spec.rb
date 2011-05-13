require 'spec_helper'

describe "LayoutLinks" do

  [
    ['/', 'Home'],
    ['/contact', 'Contact'],
    ['/about', 'About'],
    ['/help', 'Help'],
    ['/signup', 'Sign Up']
  ].each do |path, page_name|
    it "should have a #{page_name} at '#{path}'" do
      get path
      response.should have_selector('title', :content=>page_name)
    end
  end

  [
    ['About', 'About'],
    ['Help', 'Help'],
    ['Contact', 'Contact'],
    ['Home', 'Home'],
    ['Sign up now!', 'Sign Up']
  ].each do |link_text, page_name|
    it "should have the right links on the layout" do
      visit root_path
      click_link link_text
      response.should have_selector('title', :content => page_name)
    end
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign in")
    end
  end

  describe "shen signed in" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profile")

    end
  end
end
