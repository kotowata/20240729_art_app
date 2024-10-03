require 'rails_helper'

RSpec.describe '検索機能', type: :system do
  let(:user) { create(:user) }
  let(:post1) { create(:post, title: '印象派のモネ', content: '睡蓮が有名です', start_date: '2020-01-01', end_date: '2020-12-31') }
  let(:post2) { create(:post, title: '奇才ゴッホ', content: 'The天才ってイメージです', start_date: '2020-01-01', end_date: '2020-01-31') }
  let(:post3) { create(:post, title: 'ぴかぴかピカソ', content: '強烈な色彩感覚ですね', start_date: '2023-01-01', end_date: '2025-12-31') }
  let(:post4) { create(:post, title: 'サルバドール・ダリ', content: '特徴的なお髭', start_date: '2024-10-03', end_date: '2025-10-31') }

  describe '投稿一覧画面' do
    describe 'ワード検索' do
      before do
        login_as(user)
        post1
        post2
        visit posts_path
      end
      context '検索条件に該当するポストがある場合' do
        describe 'タイトルでの検索機能の検証' do
          it '該当するポストのみ表示されること' do
            fill_in 'q_title_or_content_cont', with: 'モネ'
            click_on '検索'
            Capybara.assert_current_path("/posts", ignore_query: true)
            expect(current_path).to eq(posts_path), 'ポスト一覧でないページに遷移しています'
            expect(page).to have_content(post1.title), 'ポストタイトルでの検索機能が正しく機能していません'
            expect(page).not_to have_content(post2.title), 'ポストタイトルでの検索機能が正しく機能していません'
          end
        end

        describe '本文での検索機能の検証' do
          it '該当するポストのみ表示されること' do
            fill_in 'q_title_or_content_cont', with: '天才'
            click_on '検索'
            Capybara.assert_current_path("/posts", ignore_query: true)
            expect(current_path).to eq(posts_path), 'ポスト一覧でないページに遷移しています'
            expect(page).to have_content(post2.title), 'ポスト本文での検索機能が正しく機能していません'
            expect(page).not_to have_content(post1.title), 'ポスト本文での検索機能が正しく機能していません'
          end
        end
      end

      context '検索条件に該当するポストがない場合' do
        it '1件もない旨のメッセージが表示されること' do
          fill_in 'q_title_or_content_cont', with: '一件もヒットしないよ'
          click_on '検索'
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq(posts_path), 'ポスト一覧でないページに遷移しています'
          expect(page).to have_content('ポストがありません'), '1件もヒットしない場合、「ポストがありません」というメッセージが表示されていません'
        end
      end
    end

    describe '開催中ボタン' do
      context '開催中のイベントポストがある場合' do
        before do
          login_as(user)
          post1
          post2
          post3
          post4
          visit posts_path
        end
        it '開催中のポストのみ表示されること' do
          click_on '開催中のイベントを見る'
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq(posts_path), 'ポスト一覧でないページに遷移しています'
          expect(page).to have_content(post3.title), '会期絞り込み機能が正しく機能していません'
          expect(page).to have_content(post4.title), '会期絞り込み機能が正しく機能していません'
          expect(page).not_to have_content(post1.title), '会期絞り込み機能が正しく機能していません'
          expect(page).not_to have_content(post2.title), '会期絞り込み機能が正しく機能していません'
        end
      end
      context '開催中のイベントポストがない場合' do
        before do
          login_as(user)
          post1
          post2
          visit posts_path
        end
        it '1件もない旨のメッセージが表示されること' do
          click_on '開催中のイベントを見る'
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq(posts_path), 'ポスト一覧でないページに遷移しています'
          expect(page).to have_content('ポストがありません'), '開催中イベントがない場合、「ポストがありません」というメッセージが表示されていません'
        end
      end
    end

    describe '全て表示ボタン' do
      before do
        login_as(user)
        post1
        post2
        post3
        post4
        visit posts_path
      end
      it 'すべてのポストが表示されること' do
        fill_in 'q_title_or_content_cont', with: 'モネ'
        click_on '検索'
        Capybara.assert_current_path("/posts", ignore_query: true)
        expect(current_path).to eq(posts_path), 'ポスト一覧でないページに遷移しています'
        click_on '全て表示'
        expect(page).to have_content(post1.title), '全て表示機能が正しく機能していません'
        expect(page).to have_content(post2.title), '全て表示機能が正しく機能していません'
        expect(page).to have_content(post3.title), '全て表示機能が正しく機能していません'
        expect(page).to have_content(post4.title), '全て表示機能が正しく機能していません'
      end
    end
  end
end
