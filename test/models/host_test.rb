require "test_helper"

class GuestTest < ActiveSupport::TestCase
  include SharedUsersTest

  test "User type should be host" do
    host = create(:host)

    assert host.persisted?
    assert host.host?
  end

  test "Host model should not have reservations association" do
    associations = Host.reflect_on_all_associations.map(&:name)

    assert_not_includes associations, :reservations, "Host model incorrectly has a :reservations association"
  end
end
