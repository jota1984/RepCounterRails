require 'test_helper'

class BioEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bio_entries_index_url
    assert_response :success
  end

end
