require 'test_helper'

class CreditControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get credit_show_url
    assert_response :success
  end

end
