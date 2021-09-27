require "test_helper"

class ProcessFileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get process_file_index_url
    assert_response :success
  end
end
