require 'rails_helper'

RSpec.describe Like, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      like = build(:like)
      expect(like).to be_valid
    end
  end

  context 'ユーザーと掲示板の組み合わせがユニークでない場合' do
    it '無効であること' do
      like = create(:like)
      new_like = build(:like, user: like.user, post: like.post)
      new_like.valid?
      expect(new_like.errors[:user_id]).to include('はすでに存在します'), 'likeとuserのユニークバリデーションが設定されていません'
    end
  end
end
