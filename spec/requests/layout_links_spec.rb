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
end
