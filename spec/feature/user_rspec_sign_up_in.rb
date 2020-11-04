require 'rails_helper'

RSpec.feature 'test', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'Feature spec/功能測試' do
    before(:each) do
      visit new_user_session_path
    end

    scenario 'User sign up' do
      expect(User.count).to eq(0)
      find('.sign-up').click
      expect(page).to have_content '註冊'
      fill_in('Email', with: 'test123@gmail.com')
      fill_in('Password', with: 'asdf1234')
      fill_in('Password confirmation', with: 'asdf1234')
      click_button('註冊')
      expect(page).to have_content 'Welcome! You have signed up successfully.'
      expect(User.count).to eq(1)

      find('.sign-out').click
      expect(page).to have_content '登入'
      fill_in('Email', with: 'test123@gmail.com')
      fill_in('Password', with: 'asdf1234')
      click_button('登入')
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
