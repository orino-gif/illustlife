require 'rails_helper'

RSpec.describe "Resumes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/resumes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
