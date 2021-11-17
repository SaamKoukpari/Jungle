require 'rails_helper'

RSpec.feature "User Logins", type: :feature, js: true do
  
  before :each do
    @user = User.create!(
      name: 'Shaan',
      email: 'shaanip@hotmail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  scenario 'User can login and is automatically redirected to homepage' do
    #ACT
    visit login_path
    fill_in 'email', with: 'shaanip@hotmail.com'
    fill_in 'password', with: 'password'
    click_button "Log In"
    
    #VERIFY
    expect(page).to have_content 'Logout'
    expect(page).to have_text 'Signed in as Shaan'
    
    #DEBUG
    save_screenshot 
  end

end
