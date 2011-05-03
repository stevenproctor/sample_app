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
end
