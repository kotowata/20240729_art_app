require 'rails_helper'

RSpec.describe 'ポスト', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'ポストのCRUD' do
    describe 'ポストの一覧' do
      context 'ログインしていない場合' do
        it 'ヘッダーのリンクからポスト一覧へ遷移できること' do
          visit root_path
          click_on('ポスト一覧')
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq('/posts'), 'ヘッダーのリンクからポスト一覧画面へ遷移できません'
        end

        it 'ポストの一覧が表示されること' do
          post
          visit '/posts'
          expect(page).to have_content(post.title), 'ポスト一覧画面にポストのタイトルが表示されていません'
          expect(page).to have_content(post.user.nick_name), 'ポスト一覧画面にポスト者のニックネームが表示されていません'
          expect(page).to have_content(post.content), 'ポスト一覧画面にポストの本文が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login_as(user)
        end

        it 'ヘッダーのリンクからポスト一覧へ遷移できること' do
          visit root_path
          click_on('ポスト一覧')
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq('/posts'), 'ヘッダーのリンクからポスト一覧画面へ遷移できません'
        end

        context 'ポストが一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            visit '/posts'
            expect(page).to have_content('ポストがありません'), 'ポストが一件もない場合、「ポストがありません」というメッセージが表示されていません'
          end
        end

        context 'ポストがある場合' do
          it 'ポストの一覧が表示されること' do
            post
            visit '/posts'
            expect(page).to have_content(post.title), 'ポスト一覧画面にポストのタイトルが表示されていません'
            expect(page).to have_content(post.user.nick_name), 'ポスト一覧画面にポスト者のニックネームが表示されていません'
            expect(page).to have_content(post.content), 'ポスト一覧画面にポストの本文が表示されていません'
          end
        end
      end
    end
  end
end
