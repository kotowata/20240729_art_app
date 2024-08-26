require 'rails_helper'

RSpec.describe '共通系', type: :system do
  context 'ログイン前' do
    before do
      visit root_path
    end
    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること' do
        expect(page).to have_content('ログイン'), 'ヘッダーに「ログイン」というテキストが表示されていません'
      end
    end

    describe 'フッター' do
      it 'フッターが正しく表示されていること' do
        expect(page).to have_content('Copyright'), '「Copyright」というテキストが表示されていません'
      end
    end
  end

  context 'ログイン後' do
    let(:user) { create(:user) }
    before do
      login_as(user)
    end
    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること', js: true do
        expect(page).to have_content('ポスト一覧'), 'ヘッダーに「ポスト一覧」というテキストが表示されていません'
        expect(page).to have_content('新規投稿'), 'ヘッダーに「新規投稿」というテキストが表示されていません'
        expect(page).to have_content('マイページ'), 'ヘッダーに「マイページ」というテキストが表示されていません'
        expect(page).to have_content('ログアウト'), 'ヘッダーに「ログアウト」というテキストが表示されていません'
      end
    end
  end
end
