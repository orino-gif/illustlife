require 'rails_helper'

RSpec.describe Request do
  describe '#new' do
    it 'リクエストIDが1がrinoだった場合' do
      request = Request.find(1)
      expect(request.receiver).to eq 'rino'
    end
  end
end