require 'test_helper'

class SkusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get skus_index_url
    assert_response :success
  end

end
