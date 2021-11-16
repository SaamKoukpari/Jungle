require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "Should save a new user if all validations pass" do
      @user = User.new(name: "Shaan", email: "shaanip@hotmail.com", password: "password", password_confirmation: "password")
      @user.valid?
      expect(@user.errors.full_messages).not_to include("can/'t be blank")
    end

    it "Should fail to create a user if password and password_confirmation don't match" do
      @user = User.new(password: "password", password_confirmation: "passwords") 
      @user.valid? 
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "Should fail to create a user if email is not unique and it should not be case sensitive" do
      @user = User.new(name: "Shaan", email:"shaanip@hotmail.com", password: "password", password_confirmation: "password") 
      @user.save
      @user2 = User.new(name: "Shaan", email:"SHAANIP@hotmail.com", password: "password", password_confirmation: "password") 
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "Should fail to create a user if password is < 6 characters" do
      @user = User.new(name: "Shaan", email:"shaanip@hotmail.com", password: "pass", password_confirmation: "password") 
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should log the user in if the credentials are correct' do
      @user = User.new(name: "Shaan", email:"shaanip@hotmail.com", password: "password", password_confirmation: "password") 
      @user.save
      expect(User.authenticate_with_credentials("shaanip@hotmail.com", "password")).to be_present
    end

    it 'should not authenticate the user if the email is incorrect' do
      @user = User.new(name: "Shaan", email:"shaanip@hotmail.com", password: "password", password_confirmation: "password") 
      @user.save
      expect(User.authenticate_with_credentials("donny_robert@msn.com", "password")).not_to be_present
    end

    it 'should not authenticate the user if the password is incorrect' do
      @user = User.new(name: "Shaan", email:"shaanip@hotmail.com", password: "password", password_confirmation: "password") 
      @user.save
      expect(User.authenticate_with_credentials("shaanip@hotmail.com", "ABCDEFG")).not_to be_present
    end

    it 'should log the authenticate the user if the email contains spaces' do
      @user = User.new(name: "Shaan", email:"shaanip@hotmail.com", password: "password", password_confirmation: "password") 
      @user.save
      expect(User.authenticate_with_credentials("  shaanip@hotmail.com   ", "password")).to be_present
    end

    it 'should authenticate the user if the email is typed with a different case' do
      @user = User.new(name: "Shaan", email:"shaanip@hotmail.com", password: "password", password_confirmation: "password") 
      @user.save
      expect(User.authenticate_with_credentials("  SHAANIP@hotmail.com   ", "password")).to be_present
    end

  end
end


