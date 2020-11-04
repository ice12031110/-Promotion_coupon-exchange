require 'rails_helper'

RSpec.feature 'test', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'Feature spec/功能測試' do
    before(:each) do
      visit new_user_session_path
    end

    scenario 'Exchange' do
      #創建帳號
      expect(User.count).to eq(0)
      find('.sign-up').click
      expect(page).to have_content '註冊'
      fill_in('Email', with: 'test123@gmail.com')
      fill_in('Password', with: 'asdf1234')
      fill_in('Password confirmation', with: 'asdf1234')
      click_button('註冊')
      expect(page).to have_content 'Welcome! You have signed up successfully.'
      expect(User.count).to eq(1)
      
      #登入帳號
      find('.sign-out').click
      expect(page).to have_content '登入'
      fill_in('Email', with: 'test123@gmail.com')
      fill_in('Password', with: 'asdf1234')
      click_button('登入')
      expect(page).to have_content 'Signed in successfully.'

      #兌換失敗-不符合統編規格
      expect(page).to have_content '振興兌換券'
      fill_in('公司名稱', with: '五倍紅寶石')
      fill_in('公司統編', with: '12222539')
      fill_in('聯絡電話', with: '23315247')
      click_button('兌換')
      expect(page).to have_content "您所填的統一編號有誤，請確認後重新輸入!"
      #兌換失敗-只有7個號碼
      expect(page).to have_content '振興兌換券'
      fill_in('公司名稱', with: '五倍紅寶石')
      fill_in('公司統編', with: '1289231')
      fill_in('聯絡電話', with: '23315247')
      click_button('兌換')
      expect(page).to have_content "您所填的統一編號有誤，請確認後重新輸入!"
      #兌換失敗-有9個號碼
      expect(page).to have_content '振興兌換券'
      fill_in('公司名稱', with: '五倍紅寶石')
      fill_in('公司統編', with: '128923124')
      fill_in('聯絡電話', with: '23315247')
      click_button('兌換')
      expect(page).to have_content "您所填的統一編號有誤，請確認後重新輸入!"
      #兌換成功
      expect(page).to have_content '振興兌換券'
      fill_in('公司名稱', with: '五倍紅寶石')
      fill_in('公司統編', with: '83598406')
      fill_in('聯絡電話', with: '23315247')
      click_button('兌換')
      expect(page).to have_content "已成功兌換成功，您的兌換券序號為 "
      #重複兌換
      expect(page).to have_content '振興兌換券'
      fill_in('公司名稱', with: '五倍紅寶石')
      fill_in('公司統編', with: '83598406')
      fill_in('聯絡電話', with: '23315247')
      click_button('兌換')
      expect(page).to have_content "兌換過"
    end
  end
end