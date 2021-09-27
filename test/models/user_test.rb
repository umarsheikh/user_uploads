require "test_helper"

describe User do
  describe "validations" do
    describe "#name" do
      it "should be present" do
        user = User.new
        user.password = 'Abcd123456'
        user.save
        assert_equal "Name can't be blank", user.errors.full_messages[0]
      end
    end

    describe 'password' do
      it "password has no lowercase letter" do
        user = User.new
        user.name = 'new user'
        user.password = 'ABCD123456'
        user.save
        assert_equal "Password Must contain lowercase character", user.errors.full_messages[0]
        assert_equal 1, user.count_of_corrections
      end
      it "password has no uppercase letter" do
        user = User.new
        user.name = 'new user'
        user.password = 'abcd123456'
        user.save
        assert_equal "Password Must contain uppercase character", user.errors.full_messages[0]
        assert_equal 1, user.count_of_corrections
      end

      it "password has no digit" do
        user = User.new
        user.name = 'new user'
        user.password = 'abcdEFGHIJ'
        user.save
        assert_equal "Password Must contain digit", user.errors.full_messages[0]
        assert_equal 1, user.count_of_corrections
      end

      it "password should not contain three repeating characters in a row" do
        user = User.new
        user.name = 'new user'
        user.password = 'aaaB123456'
        user.save
        assert_equal "Password has repeated characters", user.errors.full_messages[0]
        assert_equal 1, user.count_of_corrections
      end
    end
  end
end
