require 'rails_helper'

RSpec.describe "Agrees", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/agrees/show"
      expect(response).to have_http_status(:success)
    end
  end

end
