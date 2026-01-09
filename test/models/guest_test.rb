require "test_helper"

class GuestTest < ActiveSupport::TestCase
  include SharedUsersTest

  test "Guest model should have reservations association" do
    associations = Guest.reflect_on_all_associations.map(&:name)

    assert_includes associations, :reservations
  end
end
