require "test_helper"

class GuestTest < ActiveSupport::TestCase
  include SharedUsersTest

  test "User type should be guest" do
    guest = create(:guest)

    assert guest.persisted?
    assert guest.guest?
  end

  test "Guest model should have reservations association" do
    associations = Guest.reflect_on_all_associations.map(&:name)

    assert_includes associations, :reservations
  end
end
