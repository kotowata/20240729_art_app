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

  context "タイトルが255文字以下の場合" do
    it "有効であること" do
      post = build(:post, title: "a" * 255)
      expect(post).to be_valid
    end
  end

  context "タイトルが255文字以上の場合" do
    it "無効であること" do
      post = build(:post, title: "a" * 256)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include('は255文字以内で入力してください')
    end
  end

  context "本文が65535文字以内の場合" do
    it "有効であること" do
      post = build(:post, content: "a" * 65535)
      expect(post).to be_valid
    end
  end

  context "本文が65536文字以上の場合" do
    it "無効であること" do
      post = build(:post, content: "a" * 65536)
      expect(post).to be_invalid
      expect(post.errors[:content]).to include("は65535文字以内で入力してください")
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
    it "無効であること" do
      post = build(:post, event_url: "invalid_url")
      expect(post).to be_invalid
      expect(post.errors[:event_url]).to include("無効なURLです")
    end
  end
end
