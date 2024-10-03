require 'rails_helper'

RSpec.describe 'プロフィール', type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }

  it 'プロフィールの詳細が見られること' do
    find('.dropdown div[role="button"]').click
    click_on('プロフィール')
    Capybara.assert_current_path("/mypage", ignore_query: true)
    expect(current_path).to eq(mypage_path), 'プロフィールページに遷移していません'
    expect(page).to have_content(user.email), 'プロフィールページにメールアドレスが表示されていません'
    expect(page).to have_content(user.nick_name), 'プロフィールページにニックネームが表示されていません'
    expect(page).to have_css("img[src]"), '画像が表示されていません'
  end

  it 'プロフィールの編集ができること' do
    find('.dropdown div[role="button"]').click
    click_on('プロフィール')
    click_on('編集')
    Capybara.assert_current_path("/mypage/edit", ignore_query: true)
    expect(current_path).to eq(edit_mypage_path), 'プロフィール編集ページに遷移していません'
    fill_in 'ニックネーム', with: '編集後ニックネーム'
    fill_in 'メールアドレス', with: 'edit@example.com'
    file_path = Rails.root.join('spec', 'fixtures', 'user_sample.png')
    attach_file "アイコン", file_path
    click_button '更新'
    Capybara.assert_current_path("/mypage", ignore_query: true)
    expect(current_path).to eq(mypage_path), 'プロフィールページに遷移していません'
    expect(page).to have_content('ユーザー情報を更新しました'), 'フラッシュメッセージ「ユーザー情報を更新しました」が表示されていません'
    expect(page).to have_content('edit@example.com'), '更新後のメールアドレスが表示されていません'
    expect(page).to have_content('編集後ニックネーム'), '更新後のニックネームが表示されていません'
    expect(page).to have_selector("img[src$='user_sample.png']"), '更新後のアイコンが表示されていません'
  end

  it 'プロフィールの編集に失敗すること' do
    find('.dropdown div[role="button"]').click
    click_on('プロフィール')
    click_on('編集')
    Capybara.assert_current_path("/mypage/edit", ignore_query: true)
    expect(current_path).to eq(edit_mypage_path), 'プロフィール編集ページに遷移していません'

    page.execute_script("document.querySelector('form').setAttribute('novalidate', 'novalidate')")

    expect {
      fill_in 'ニックネーム', with: ''
      fill_in 'メールアドレス', with: ''
      click_button '更新'
    }.to change { User.count }.by(0)

    expect(page).to have_content('ユーザー情報を更新できませんでした'), 'フラッシュメッセージ「ユーザー情報を更新できませんでした」が表示されていません'
    expect(page).to have_content('メールアドレスを入力してください'), 'エラーメッセージ「メールアドレスを入力してください」が表示されていません'
    expect(page).to have_content('ニックネームを入力してください'), 'エラーメッセージ「ニックネームを入力してください」が表示されていません'
  end
end
