require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "ホームページ(#page)" do
    it "レスポンスが２００であること(home#page)" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
