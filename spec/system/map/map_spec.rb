require 'rails_helper'

RSpec.describe 'マップ', type: :system do
  let(:user) { create(:user) }

  describe 'マップの表示' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit map_path
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインしてください'
      end
    end

    context 'ログインしている場合' do
      it 'ヘッダーのリンクからマップ画面へ遷移できること' do
        login_as(user)
        click_on('探す')
        Capybara.assert_current_path("/maps", ignore_query: true)
        expect(current_path).to eq('/maps'), 'ヘッダーのリンクからマップ画面へ遷移できません'
      end

      it 'マップが表示されること' do
        login_as(user)
        click_on('探す')
        expect(page).to have_css('div#map'), 'Google Mapが表示されていません'
      end
    end
  end
end
