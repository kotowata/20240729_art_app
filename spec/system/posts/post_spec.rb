require 'rails_helper'

RSpec.describe 'ポスト', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
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
        end
      end

      context 'ログインしている場合' do
        it 'ヘッダーのリンクからポスト一覧へ遷移できること' do
          login_as(user)
          click_on('ポスト一覧')
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq('/posts'), 'ヘッダーのリンクからポスト一覧画面へ遷移できません'
        end

        it '正しいタイトルが表示されていること' do
          login_as(user)
          click_on('ポスト一覧')
          expect(page).to have_title("ポスト一覧 | (仮)卒業制作APP"), 'ポスト一覧ページのタイトルに「ポスト一覧 | (仮)卒業制作APP」が含まれていません。'
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
          end
        end

        context '6件以下の場合' do
          let!(:posts) { create_list(:post, 6)}
          it 'ページングが表示されないこと' do
            login_as(user)
            visit posts_path
            expect(page).not_to have_selector('.pagination')
          end
        end

        context '7件以上ある場合' do
          let!(:posts) { create_list(:post, 7)}
          it 'ページングが表示されること' do
            login_as(user)
            click_on('ポスト一覧')
            expect(page).to have_selector('.pagination'), 'ポスト一覧画面において掲示板が7件以上ある場合に、ページネーションのリンクが表示されていません'
          end
        end
      end
    end

    describe 'ポストの新規作成' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit '/posts/new'
          Capybara.assert_current_path("/login", ignore_query: true)
          expect(current_path).to eq('/login'), 'ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login_as(user)
          click_on('新規投稿')
        end

        it '正しいタイトルが表示されていること' do
          expect(page).to have_title("新規投稿 | (仮)卒業制作APP"), 'ポスト新規作成ページのタイトルに「新規投稿 | (仮)卒業制作APP」が含まれていません。'
        end

        it 'ポストが作成できること' do
          file_path = Rails.root.join('spec', 'fixtures', 'example.jpg')
          attach_file "写真", file_path
          fill_in 'タイトル', with: 'テストタイトル'
          fill_in 'コメント', with: 'テストコメント'
          fill_in 'イベントURL', with: 'http://example'
          click_button '登録'
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(page).to have_content('ポストを作成しました'), 'フラッシュメッセージ「ポストを作成しました」が表示されていません'
          expect(page).to have_content('テストタイトル'), '作成したポストのタイトルが表示されていません'
        end

        it 'ポストの作成に失敗すること' do
          file_path = Rails.root.join('spec', 'fixtures', 'example.txt')
          attach_file "写真", file_path
          fill_in 'コメント', with: 'テストコメント'
          click_button '登録'
          expect(page).to have_content('ポストを作成できませんでした'), 'フラッシュメッセージ「ポストを作成できませんでした」が表示されていません'
          expect(page).to have_content('タイトルを入力してください'), 'フラッシュメッセージ「タイトルを入力してください」が表示されていません'
        end
      end
    end
    describe 'ポストの詳細' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit post_path(post)
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインしてください'
        end
      end

      context 'ログインしている場合' do
        before do
          post
          login_as(user)
        end
        it 'ポストの詳細が表示されること' do
          click_on('ポスト一覧')
          within "#post-id-#{post.id}" do
            page.find_link(post.title).click
          end
          Capybara.assert_current_path("/posts/#{post.id}", ignore_query: true)
          expect(current_path).to eq("/posts/#{post.id}"), 'ポストのタイトルリンクからポスト詳細画面へ遷移できません'
          expect(page).to have_content post.title
          expect(page).to have_content post.user.nick_name
          expect(page).to have_content post.content
        end
        it '正しいタイトルが表示されていること' do
          click_on('ポスト')
          click_on('ポスト一覧')
          within "#post-id-#{post.id}" do
            page.find_link(post.title).click
          end
          expect(page).to have_title("#{post.title} | (仮)卒業制作APP"), 'ポスト詳細ページのタイトルにポストのタイトルが含まれていません。'
        end
      end
    end

    describe 'ポストの更新' do
      context 'ログインしていない場合' do
        before { post }
        it 'ログインページにリダイレクトされること' do
          visit edit_post_path(post)
          expect(current_path).to eq('/login'), 'ログインページにリダイレクトされていません'
          expect(page).to have_content 'ログインしてください'
        end
      end

      context 'ログインしている場合' do
        before do
          login_as(user)
          post
        end

        context '自分のポスト' do
          it "ポストが更新できること" do
            click_on 'ポスト一覧'
            find("#button-edit-#{post.id}").click

            fill_in 'タイトル', with: '編集後テストタイトル'
            fill_in 'コメント', with: '編集後テストコメント'
            fill_in 'イベントURL', with: 'http://example_rev00'
            click_button '更新'

            Capybara.assert_current_path("/posts/#{post.id}", ignore_query: true)
            expect(current_path).to eq post_path(post)
            expect(page).to have_content('ポストを更新しました'), 'フラッシュメッセージ「ポストを更新しました」が表示されていません'
            expect(page).to have_content('編集後テストタイトル'), '更新後のタイトルが表示されていません'
            expect(page).to have_content('編集後テストコメント'), '更新後のコメントが表示されていません'
            expect(page).to have_content('http://example_rev00'), '更新後のURLが表示されていません'
          end

          it 'ポストの更新に失敗すること' do
            click_on 'ポスト一覧'
            find("#button-edit-#{post.id}").click
            fill_in 'タイトル', with: ''
            fill_in 'コメント', with: '編集後テストコメント'
            click_button '更新'
            expect(page).to have_content('ポストを更新できませんでした'), 'フラッシュメッセージ「ポストを更新出来ませんでした」が表示されていません'
          end
        end

        context '他人のポスト' do
          it '編集ボタンが表示されないこと' do
            login_as(another_user)
            click_on 'ポスト一覧'
            expect(page).not_to have_selector("#button-edit-#{post.id}"), '他人のポストに対して編集ボタンが表示されています'
          end
        end
      end
    end

    describe 'ポストの削除' do
      before { post }
      context '自分のポスト' do
        it 'ポストが削除できること', js: true do
          login_as(user)
          click_on 'ポスト一覧'
          page.accept_confirm { find("#button-delete-#{post.id}").click }
          expect(current_path).to eq('/posts'), 'ポスト削除後に、ポストの一覧ページに遷移していません'
          expect(page).to have_content('ポストを削除しました'), 'フラッシュメッセージ「ポストを削除しました」が表示されていません'
        end
      end

      context '他人のポスト' do
        it '削除ボタンが表示されないこと' do
          login_as(another_user)
          visit posts_path
          expect(page).not_to have_selector("#button-delete-#{post.id}"), '他人のポストに対して削除ボタンが表示されています'
        end
      end
    end
  end
end
