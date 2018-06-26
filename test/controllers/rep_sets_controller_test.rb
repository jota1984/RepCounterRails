require 'test_helper'

class RepSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rep_sets_index_url
    assert_response :success
  end

  test "should get show" do
    get rep_sets_show_url
    assert_response :success
  end

end
