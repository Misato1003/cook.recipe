require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザを登録する際、バリデーションが機能しているかどうかの確認" do
    before do
      @user = User.new(
        email: "test@example.com",
        password: "123456"
      )
    end

    it "メールアドレス、パスワード(6文字以上）があれば有効であること" do
      expect(@user).to be_valid
    end

    it "メールアドレスがなければ無効であること" do
      @user = User.new(email: nil)
      expect(@user.valid?).to eq(false)
    end

    it "パスワードがなければ、無効であること" do
      @user = User.new(password: nil)
      expect(@user.valid?).to eq(false)
    end

    it "パスワードが６文字以下の場合、無効であること" do
      @user = User.new(password: 12345)
      expect(@user.valid?).to eq(false)
    end

    it "nilの場合、無効であること" do
      expect(User.new).not_to be_valid
    end

    it "ユーザーを登録する際、メールアドレスが重複している場合、無効であること" do
      User.create(
        email: "test@example.com",
        password: "345678"
      )

      @user.valid?
      expect(@user.valid?).to eq(false)
    end

    it "ユーザを登録する際、メールアドレスは違くて、パスワードが重複している場合、有効であること" do
      User.create(
        email: "sample@example.com",
        password: "123456"
      )

      @user.valid?
      expect(@user.valid?).to eq(true)
    end
  end
end
