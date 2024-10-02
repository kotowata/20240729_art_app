require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  it '正しいタイトルが表示されること' do
    visit '/users/new'
    expect(page).to have_title("ユーザー登録 | ArtSpotly"), 'ユーザー登録ページのタイトルに「ユーザー登録 | ArtSpotly」が含まれていません。'
  end

  context '入力情報正常系' do
    it 'ユーザーが新規作成できること' do
      visit '/users/new'
      expect {
        fill_in 'nick_name', with: 'らんてくん'
        fill_in 'email', with: 'example@example.com'
        fill_in 'password', with: '12345678'
        fill_in 'password_confirmation', with: '12345678'
        file_path = Rails.root.join('spec', 'fixtures', 'user_sample.png')
        attach_file "アイコン", file_path
        click_button '登録'
        Capybara.assert_current_path("/login", ignore_query: true)
      }.to change { User.count }.by(1)
      expect(page).to have_content('ユーザー登録が完了しました'), 'フラッシュメッセージ「ユーザー登録が完了しました」が表示されていません'
    end
  end

  context '入力情報異常系' do
    it 'ユーザーが新規作成できない' do
      visit '/users/new'

      page.execute_script("document.querySelector('form').setAttribute('novalidate', 'novalidate')")

      expect {
        fill_in 'email', with: 'example@example.com'
        click_button '登録'
      }.to change { User.count }.by(0)
      expect(page).to have_content('ユーザー登録に失敗しました'), 'フラッシュメッセージ「ユーザー登録に失敗しました」が表示されていません'
      expect(page).to have_content('ニックネームを入力してください'), 'フラッシュメッセージ「ニックネームを入力してください」が表示されていません'
      expect(page).to have_content('パスワードは3文字以上で入力してください'), 'フラッシュメッセージ「パスワードは3文字以上で入力してください」が表示されていません'
    end
  end
end
