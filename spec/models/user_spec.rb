require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "姓、名、ニックネーム、メールがあり、パスワードは3文字以上であれば有効であること" do
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

    it "姓、名、ニックネーム、メールアドレスは必須項目であること" do
      user = build(:user)
      user.email = nil
      user.first_name = nil
      user.last_name = nil
      user.nick_name = nil
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
      expect(user.errors[:first_name]).to include("を入力してください")
      expect(user.errors[:last_name]).to include("を入力してください")
      expect(user.errors[:nick_name]).to include("を入力してください")
    end

    it "姓、名、ニックネームは255文字以下であること" do
      user = build(:user)
      user.first_name = "a" * 256
      user.last_name = "b" * 256
      user.nick_name = "c" * 256
      user.valid?
      expect(user.errors[:first_name]).to include('は255文字以内で入力してください')
      expect(user.errors[:last_name]).to include('は255文字以内で入力してください')
      expect(user.errors[:nick_name]).to include('は255文字以内で入力してください')
    end
  end
end
