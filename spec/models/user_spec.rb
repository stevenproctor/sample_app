require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email address" do
    no_name_user = User.new(@attr.merge(:email => ""))
    no_name_user.should_not be_valid
  end

  it "should reject names that are too long" do
    expected_max_name_length = 50
    long_name = "a" * (expected_max_name_length + 1)
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  describe "email validations" do

     %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |address|
      it "should accept valid email address '#{address}'" do
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end

    %w[user@foo,com user_at_foo.org example.user@foo.].each do |address|
      it "should reject invalid email address '#{address}'" do
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password and password confirmation" do
      User.new(@attr.merge(:password_confirmation => "different password")).
        should_not be_valid
    end

    it "should reject passwords shorter than the min length" do
      min_password_length = 6
      short_password = "a" * (min_password_length - 1)
      hash = @attr.merge(:password => short_password, :password_confirmation => short_password)
      User.new(hash).should_not be_valid
    end

    it "should reject passwords longer than the max length" do
      max_password_length = 40
      long_password = "a" * (max_password_length + 1)
      hash = @attr.merge(:password => long_password, :password_confirmation => long_password)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid password").should be_false
      end
    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil on email address with no user" do
        nonexistant_user = User.authenticate("bar@foo.com", "wrongpass")
        nonexistant_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end

  describe "admin attribute" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
end
