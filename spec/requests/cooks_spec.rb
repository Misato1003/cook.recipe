require 'rails_helper'

RSpec.describe "Cooks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/cooks/index"
      expect(response).to have_http_status(:success)
    end
  end
end
