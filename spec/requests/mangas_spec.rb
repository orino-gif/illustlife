require 'rails_helper'

RSpec.describe "Mangas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/mangas/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/mangas/show"
      expect(response).to have_http_status(:success)
    end
  end

end
