require 'spec_helper'

describe PagesController do
  render_views

  [
    ['home', 'Home'],
    ['contact', 'Contact'],
    ['about', 'About'],
    ['help', 'Help']
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

  describe "for a signed-in user" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should not show the new link" do
      get :home
      response.should_not have_selector("a", :content => "Sign up")
    end

  end
end
