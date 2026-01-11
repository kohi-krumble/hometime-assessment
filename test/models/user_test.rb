require "test_helper"

class UserTest < ActiveSupport::TestCase
  include SharedUsersTest

  test "User model should not have reservations association" do
    associations = User.reflect_on_all_associations.map(&:name)

    assert_not_includes associations, :reservations, "User model incorrectly has a :reservations association"
  end
end
