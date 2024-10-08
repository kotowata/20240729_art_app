require 'rails_helper'

RSpec.describe 'いいね', type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:like) { create(:like, user: user) }

  it 'いいねができること' do
    login_as(user)
    Capybara.assert_current_path("/", ignore_query: true)
    expect(current_path).to eq "/"
    expect(page).to have_content('ログインしました')
    visit '/posts'
    find("#like-button-for-post-#{post.id}").click
    expect(current_path).to eq('/posts'), 'いいね作成後に、掲示板一覧画面が表示されていません'
    expect(page).to have_content('いいねしました'), 'フラッシュメッセージ「いいねしました」が表示されていません'
  end

  it 'いいねを外せること' do
    login_as(user)
    Capybara.assert_current_path("/", ignore_query: true)
    expect(current_path).to eq "/"
    expect(page).to have_content('ログインしました')
    visit '/posts'
    # いいねを外す
    find("#unlike-button-for-post-#{like.post.id}").click
    expect(current_path).to eq('/posts'), 'いいね解除後に、掲示板一覧画面が表示されていません'
    expect(page).to have_content('いいねを外しました'), 'フラッシュメッセージ「いいねを外しました」が表示されていません'
  end
end
