require 'spec_helper'

describe PagesController do
  render_views

  [
    ['home', 'Home'],
    ['contact', 'Contact'],
    ['about', 'About']
  ].each do |action, pageName|
    describe "GET '#{action}'" do
      before(:each) do
        get "#{action}"
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title",
                                     :content => "Ruby on Rails Tutorial Sample App | #{pageName}")
      end
    end
  end
end
