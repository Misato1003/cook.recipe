require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user, email: 'sample@com.jp')
    @cook = FactoryBot.create(:cook)
    @post = FactoryBot.create(:post, cook_id: @cook.id, user_id: @user.id)
  end

  describe "Posts" do
    it "statusが２００であること(index)" do
      get posts_path
      expect(response).to have_http_status(200)
    end

    context "レビューの新規登録(cook_path)" do
      before do
        get cook_path(@cook.id)
      end

      it "statusが２００であること(new)" do
        expect(response).to have_http_status(200)
      end
    end

    context "レビューの詳細(cook_path)" do
      before do
        get cook_path(@cook.id)
      end

      it "statusが200であること(show)" do
        expect(response).to have_http_status(200)
      end

      it "レビュー内容が取得できていること" do
        expect(response.body).to include @post.content
      end

      it "nicknameが取得できていること" do
        expect(response.body).to include @post.nickname
      end

      it "user_idが取得できていること" do
        expect(response.body).to include @post.user.id.to_s
      end

      it "cook_idが取得できていること" do
        expect(response.body).to include @post.cook.id.to_s
      end
    end

    context "レビューの詳細(post_path)ログインしないと見れない" do
      before do
        get post_path(@post.id)
      end

      it "statusが２００であること(show)" do
        sign_in @user
        get cook_path(@post.id)
        expect(response).to have_http_status(200)
      end

      it "statusが302であること(show)" do
        expect(response).to have_http_status(302)
      end

      it "レビューの詳細を見る際、ログインしていない場合、ログイン画面にいくこと" do
        expect(response).to redirect_to "/users/sign_in"
      end

      it "レビュー内容が取得できていること" do
        sign_in @user
        get cook_path(@post.id)
        expect(response.body).to include @post.content
      end

      it "nicknameが取得できていること" do
        sign_in @user
        get cook_path(@post.id)
        expect(response.body).to include @post.nickname
      end

      it "user_idが取得できていること" do
        sign_in @user
        get cook_path(@post.id)
        expect(response.body).to include @post.user.id.to_s
      end

      it "cook_idが取得できていること" do
        sign_in @user
        get cook_path(@post.id)
        expect(response.body).to include @post.cook.id.to_s
      end
    end

    context "レビューの編集" do
      before do
        get "/posts/#{@post.id}/edit"
      end

      it "レビューを編集をする際、ユーザーがログインしている場合　statusが２００であること(edit)" do
        sign_in @user
        get "/posts/#{@post.id}"
        expect(response).to have_http_status(200)
      end

      it "レビューを編集をする際、ユーザーがログインしていない場合 statusが３０２であること(edit)" do
        expect(response).to have_http_status(302)
      end

      it "レビューを編集する際、ログインしていない場合、ログイン画面にいくこと" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context 'POST /posts(レビューの登録)' do
      before do
        post "/posts", params: { post: { nickname: 'NicknamePost' } }
      end

      it 'ユーザーがログインしていない場合、レビューの登録ができないこと statusが３０２であること' do
        expect(response).to have_http_status 302
      end

      it "登録する際、ユーザーがログインしていない場合、ログイン画面に行くこと" do
        expect(response).to redirect_to "/users/sign_in"
      end

      it "投稿者の名前が登録できていること" do
        expect(@post.reload.nickname).to eq "NicknamePost"
      end
    end

    context 'PATCH/PUT /posts/:id (レビューの更新)' do
      before do
        sign_in @user
        patch "/posts/#{@post.id}", params: { post: { nickname: 'NicknamePost' } }
      end

      it '何も変更しない場合、statusが３０２であること' do
        expect(response).to have_http_status 302
      end

      it "投稿者の名前が更新できていないこと" do
        expect(@post.reload.nickname).to eq "NicknamePost"
      end

      it '投稿者の名前が更新されること' do
        @post = FactoryBot.create(:post, nickname: 'new_name', cook_id: @cook.id, user_id: @user.id)
        put path, params: { post: { nickname: 'new_name' } }
        expect(@post.reload.nickname).to eq 'new_name'
      end
    end

    context 'DELEET /posts/:id (レビューの削除)' do
      before do
        delete "/posts/#{@post.id}"
      end

      it 'ユーザーがログインしないと削除できない statusが３０２であること' do
        expect(response).to have_http_status 302
      end

      it '削除する際、ログインしていない場合、ログイン画面に行くこと' do
        expect(response).to redirect_to "/users/sign_in"
      end

      it 'ユーザーがログインして、投稿したレビューが削除できること' do
        sign_in @user
        delete "/posts/#{@post.id}"
        expect(Post.all.count).to eq 0
      end
    end
  end
end
