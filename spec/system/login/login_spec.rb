require 'rails_helper'

RSpec.describe 'ログイン・ログアウト', type: :system do
  let(:user) { create(:user) }

  describe '通常画面' do
    describe 'ログイン' do
      it '正しいタイトルが表示されていること' do
        visit '/login'
        expect(page).to have_title("ログイン | ArtSpotly"), '掲示板一覧ページのタイトルに「ログイン | ArtSpotly」が含まれていません。'
      end

      context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit '/login'
          fill_in 'email', with: user.email
          fill_in 'password', with: '12345678'
          click_button 'ログイン'
          Capybara.assert_current_path("/", ignore_query: true)
          expect(current_path).to eq "/"
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
        end
      end

      context 'PWに誤りがある場合' do
        it 'ログインできないこと' do
          visit '/login'
          fill_in 'email', with: user.email
          fill_in 'password', with: '1234'
          click_button 'ログイン'
          Capybara.assert_current_path("/login", ignore_query: true)
          expect(current_path).to eq('/login'), 'ログイン失敗時にログイン画面に戻ってきていません'
          expect(page).to have_content('ログインに失敗しました'), 'フラッシュメッセージ「ログインに失敗しました」が表示されていません'
        end
      end
    end

    describe 'ログアウト' do
      before do
        login_as(user)
      end
      it 'ログアウトできること' do
        find('.dropdown div[role="button"]').click
        click_on('ログアウト')
        Capybara.assert_current_path("/", ignore_query: true)
        expect(current_path).to eq root_path
        expect(page).to have_content('ログアウトしました'), 'フラッシュメッセージ「ログアウトしました」が表示されていません'
      end
    end
  end
end
