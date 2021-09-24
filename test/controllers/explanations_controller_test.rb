require 'test_helper'

class ExplanationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get explanations_show_url
    assert_response :success
  end

end
