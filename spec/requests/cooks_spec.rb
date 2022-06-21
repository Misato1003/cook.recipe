require 'rails_helper'

RSpec.describe "Cooks", type: :request do
  before do
    @user = FactoryBot.create(:user, email: 'sample@com.jp')
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

    context "料理の編集" do
      before do
        get "/cooks/#{@cook.id}/edit"
      end

      it "料理を編集をする際、ユーザーがログインしている場合　statusが２００であること(edit)" do
        sign_in @user
        get "/cooks/#{@cook.id}"
        expect(response).to have_http_status(200)
      end

      it "ユーザーがログインしていない場合 statusが３０２であること(edit)" do
        expect(response).to have_http_status(302)
      end

      it "料理を編集する際、ユーザーがログインしていない場合、ログイン画面にいくこと" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context 'POST /cooks' do
      before do
        post "/cooks", params: { cook: { name: 'CookName' } }
      end

      it "ユーザーがログインしている場合、料理の登録ができること statusが２００であること" do
        sign_in @user
        post "/cooks", params: { cook: { name: 'CookName' } }
        expect(response).to have_http_status 200
      end

      it 'ユーザーがログインしていない場合、料理の登録ができないこと statusが３０２であること' do
        expect(response).to have_http_status 302
      end

      it "登録する際、ユーザーがログインしていない場合、ログイン画面に行くこと" do
        expect(response).to redirect_to "/users/sign_in"
      end

      it "登録できていること" do
        expect(@cook.reload.name).to eq "CookName"
      end
    end

    context 'PATCH/PUT /cooks/:id' do
      before do
        sign_in @user
        patch "/cooks/#{@cook.id}", params: { cook: { name: 'CookName' } }
      end

      it '何も変更しない場合、statusが３０２であること' do
        expect(response).to have_http_status 302
      end

      it "料理名が更新できていないこと" do
        expect(@cook.reload.name).to eq "CookName"
      end

      it '料理名が更新される' do
        @cook = FactoryBot.create(:cook, name: 'new_name')
        put path, params: { cook: { name: 'new_name' } }
        expect(@cook.reload.name).to eq 'new_name'
      end
    end

    context 'DELEET /cooks/:id' do
      before do
        delete "/cooks/#{@cook.id}"
      end

      it 'ユーザーがログインしないと削除できない statusが３０２であること' do
        expect(response).to have_http_status 302
      end

      it '削除する際、ログインしていない場合、ログイン画面に行くこと' do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
