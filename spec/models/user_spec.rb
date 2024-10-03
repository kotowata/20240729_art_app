require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "ニックネーム、メールがあり、パスワードは3文字以上であれば有効であること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "メールはユニークであること" do
      user1 = create(:user)
      user2 = build(:user)
      user2.email = user1.email
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    it "ニックネーム、メールアドレスは必須項目であること" do
      user = build(:user)
      user.email = nil
      user.nick_name = nil
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
      expect(user.errors[:nick_name]).to include("を入力してください")
    end

    it "ニックネームは255文字以下であること" do
      user = build(:user)
      user.nick_name = "c" * 256
      user.valid?
      expect(user.errors[:nick_name]).to include('は255文字以内で入力してください')
    end

    it "メールアドレスの形式が有効であること" do
      user = build(:user, email: "invalid_email")
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("は不正な値です")
    end

  end
end
