require 'rails_helper'

RSpec.describe "Cooks", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @cook = FactoryBot.create(:cook)
  end

  describe "Cooks" do
    it "statusが２００であること(index)" do
      get cooks_path
      expect(response).to have_http_status(200)
    end

    context "料理の新規登録" do
      before do
        get new_cook_path
      end

      it "ユーザーがログインしている場合　statusが２００であること(new)" do
        sign_in @user
        get new_cook_path
        expect(response).to have_http_status(200)
      end

      it "ユーザーがログインしていない場合　statusが３０２であること(new)" do
        expect(response).to have_http_status(302)
      end

      it "料理を新規登録する際、ログインしていない場合、ログイン画面にいくこと" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "料理の詳細" do
      before do
        get cook_path(@cook.id)
      end

      it "statusが200であること(show)" do
        expect(response).to have_http_status(200)
      end

      it "料理名が取得できていること" do
        expect(response.body).to include @cook.name
      end

      it "食材が取得できていること" do
        expect(response.body).to include @cook.ingredient
      end

      it "作り方が取得できていること" do
        expect(response.body).to include @cook.recipe
      end
    end
  end
end
