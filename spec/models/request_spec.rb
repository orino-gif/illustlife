require 'rails_helper'

RSpec.describe 'requests_controller' do
  describe '#index' do
    it 'リクエストID1のreceiverがrinoだった場合' do
      request = Request.find(1)
      expect(request.receiver).to eq 'rino'
    end
  end
end