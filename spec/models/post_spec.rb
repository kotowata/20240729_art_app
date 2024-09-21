require 'rails_helper'

RSpec.describe Post, type: :model do
  context "全てのフィールドが有効な場合" do
    it "有効であること" do
      post = build(:post)
      expect(post).to be_valid
    end
  end

  context "タイトルが存在しない場合" do
    it "無効であること" do
      post = build(:post, title: nil)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("を入力してください")
    end
  end

  context "タイトルが30文字以下の場合" do
    it "有効であること" do
      post = build(:post, title: "a" * 30)
      expect(post).to be_valid
    end
  end

  context "タイトルが30文字以上の場合" do
    it "無効であること" do
      post = build(:post, title: "a" * 31)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include('は30文字以内で入力してください')
    end
  end

  context "本文が140文字以内の場合" do
    it "有効であること" do
      post = build(:post, content: "a" * 140)
      expect(post).to be_valid
    end
  end

  context "本文が140文字以上の場合" do
    it "無効であること" do
      post = build(:post, content: "a" * 141)
      expect(post).to be_invalid
      expect(post.errors[:content]).to include("は140文字以内で入力してください")
    end
  end

  context "URLが255文字以下の有効なURLの場合" do
    it "有効であること" do
      post = build(:post, event_url: "http://example.com")
      expect(post).to be_valid
    end
  end

  context "URLが255文字以上の場合" do
    it "無効であること" do
      long_url = 'http://' + 'a' * 250
      post = build(:post, event_url: long_url)
      expect(post).to be_invalid
      expect(post.errors[:event_url]).to include("は255文字以内で入力してください")
    end
  end

  context "URLが空欄の場合" do
    it "有効であること" do
      post = build(:post, event_url: "")
      expect(post).to be_valid
    end
  end

  context "URLが無効な形式の場合" do
    fit "無効であること" do
      post = build(:post, event_url: "invalid_url")
      expect(post).to be_invalid
      expect(post.errors[:event_url]).to include("無効なURLです")
    end
  end

  context "開始日と終了日が入力されている場合" do
    it "有効であること" do
      post = build(:post, start_date: "2024-09-01", end_date: "2024-09-30")
      expect(post).to be_valid
    end
  end

  context "開始日が空欄の場合" do
    it "有効であること" do
      post = build(:post, start_date: "")
      expect(post).to be_valid
    end
  end

  context "終了日が空欄の場合" do
    it "有効であること" do
      post = build(:post, end_date: "")
      expect(post).to be_valid
    end
  end

  context "所在地が空欄の場合" do
    it "有効であること" do
      post = build(:post, prefecture_id: "")
      expect(post).to be_valid
    end
  end

  context "所在地が選択済みの場合" do
    it "有効であること" do
      post = build(:post, prefecture_id: "1")
      expect(post).to be_valid
    end
  end
end
