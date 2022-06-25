require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "レビューを登録する際、バリデーションが効いているかの確認" do
    before do
      @user = FactoryBot.create(:user, email: 'sample@com.jp')
      @cook = FactoryBot.create(:cook)
    end

    it "レビューを登録する際、user_id, cook_idがあれば、有効である" do
      post = build(:post, user_id: @user.id, cook_id: @cook.id)
      expect(post).to be_valid
    end

    it "user_idがnilの場合、無効である" do
      post = build(:post, user_id: nil, cook_id: @cook.id)
      expect(post.valid?).to eq(false)
    end

    it "cook_idがnilの場合、無効である" do
      post = build(:post, user_id: @user.id, cook_id: nil)
      expect(post.valid?).to eq(false)
    end

    it "cook_id, user_idがnilの場合、無効である" do
      post = build(:post, user_id: nil, cook_id: nil)
      expect(post).not_to be_valid
    end

    it "content,nicknameがnilの場合、有効である" do
      post = build(:post, user_id: @user.id, cook_id: @cook.id, content: "nil", nickname: "nil")
      expect(post).to be_valid
    end
  end
end
