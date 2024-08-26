require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  context '入力情報正常系' do
    it 'ユーザーが新規作成できること' do
      visit '/users/new'
      expect {
        fill_in 'last_name', with: 'らんてっく'
        fill_in 'first_name', with: 'たろう'
        fill_in 'nick_name', with: 'らんてくん'
        fill_in 'email', with: 'example@example.com'
        fill_in 'password', with: '12345678'
        fill_in 'password_confirmation', with: '12345678'
        click_button '登録'
        Capybara.assert_current_path("/login", ignore_query: true)
      }.to change { User.count }.by(1)
      expect(page).to have_content('ユーザー登録が完了しました'), 'フラッシュメッセージ「ユーザー登録が完了しました」が表示されていません'
    end
  end

  context '入力情報異常系' do
    it 'ユーザーが新規作成できない' do
      visit '/users/new'
      expect {
        fill_in 'first_name', with: 'a'
        fill_in 'last_name', with: 'a'
        fill_in 'nick_name', with: 'a'
        fill_in 'email', with: 'example@example.com'
        fill_in 'password', with: 'a'
        fill_in 'password_confirmation', with: 'a'
        click_button '登録'
      }.to change { User.count }.by(0)
      expect(page).to have_content('ユーザー登録に失敗しました'), 'フラッシュメッセージ「ユーザー登録に失敗しました」が表示されていません'
    end
  end
end
