require 'rails_helper'

RSpec.describe "Exposures", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/exposures/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/exposures/show"
      expect(response).to have_http_status(:success)
    end
  end

end
