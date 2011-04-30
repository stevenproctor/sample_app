require 'spec_helper'

describe PagesController do
  render_views

  [
    ['home', 'Home'],
    ['contact', 'Contact'],
    ['about', 'About']
  ].each do |action, pageName|
    describe "GET '#{action}'" do
      it "should be successful" do
        get "#{action}"
        response.should be_success
      end

      it "should have the right title" do
        get "#{action}"
        response.should have_selector("title",
                                     :content => "Ruby on Rails Tutorial Sample App | #{pageName}")
      end
    end
  end
end
