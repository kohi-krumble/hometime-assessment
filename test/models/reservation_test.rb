require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  test "Successfully creates a reservation when all required fields are provided" do
    reservation = create(:reservation)

    assert reservation.persisted?
  end
end
