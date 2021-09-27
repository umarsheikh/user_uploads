require "test_helper"

class ProcessFileControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get process_file_import_url
    assert_response :success
  end

  describe 'users file upload' do
    let(:file) { fixture_file_upload('users.csv', 'text/csv') }

    it 'invalid user upload' do
      post '/process_file/import', params: {file: file}
      assert_response :success
      assert_select '.users', /Change 2 characters of sajidalisheikh's password/
    end

    it 'valid user upload' do
      post '/process_file/import', params: {file: file}
      assert_response :success
      assert_select '.users', /umarsheikh was successfully saved/
    end
  end
end
