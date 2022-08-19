require 'rails_helper'

RSpec.describe "Mangas", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/manga/show"
      expect(response).to have_http_status(:success)
    end
  end

end
