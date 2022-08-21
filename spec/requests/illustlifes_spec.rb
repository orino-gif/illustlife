require 'rails_helper'

RSpec.describe "Illustlifes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/illustlifes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/illustlifes/show"
      expect(response).to have_http_status(:success)
    end
  end

end
