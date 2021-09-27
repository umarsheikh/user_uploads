require "test_helper"

class ProcessFileControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get process_file_import_url
    assert_response :success
  end
end
