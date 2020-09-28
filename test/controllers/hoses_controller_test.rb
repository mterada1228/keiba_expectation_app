require 'test_helper'

class HosesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get hoses_show_url
    assert_response :success
  end

end
