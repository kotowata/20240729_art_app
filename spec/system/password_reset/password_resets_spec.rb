require 'rails_helper'

RSpec.describe 'パスワードリセット', type: :system do
  let(:user) { create(:user) }

  describe 'タイトル' do
    describe 'パスワードリセット申請ページ' do
      it '正しいタイトルが表示されていること' do
        visit new_password_reset_path
        expect(page).to have_title('パスワードリセット申請'), 'パスワードリセット申請ページのタイトルに「パスワードリセット申請」が含まれていません'
      end
    end

    describe 'パスワードリセットページ' do
      it '正しいタイトルが表示されていること' do
        user.generate_reset_password_token!
        visit edit_password_reset_path(user.reset_password_token)
        expect(page).to have_title('パスワードリセット'), 'パスワードリセットページのタイトルに「パスワードリセット」が含まれていません'
      end
    end
  end

  it 'パスワードが変更できる' do
    visit new_password_reset_path
    fill_in 'メールアドレス', with: user.email
    click_button '送信'
    expect(page).to have_content('パスワードリセット申請メールを送信しました'), 'フラッシュメッセージ「パスワードリセット申請メールを送信しました」が表示されていません'
    visit edit_password_reset_path(user.reload.reset_password_token)
    fill_in 'パスワード', with: '123456789'
    fill_in 'パスワード確認', with: '123456789'
    click_button '更新'
    Capybara.assert_current_path("/login", ignore_query: true)
    expect(current_path).to eq(login_path), 'パスワードリセット後にログイン画面に遷移していません'
    expect(page).to have_content('パスワードを変更しました'), 'フラッシュメッセージ「パスワードを変更しました」が表示されていません'
  end
end