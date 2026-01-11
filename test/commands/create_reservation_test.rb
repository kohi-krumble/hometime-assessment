require 'test_helper'
class CreateReservationTest < ActiveSupport::TestCase
  
  setup do
    @guest = create(:guest)
  end

  test "should create reservation with parsed payload" do
    assert_difference 'Reservation.count', 1 do
      command = CreateReservation.new(parsed_payload).call
      reservation = command.result

      assert reservation.persisted?
      assert_equal reservation.guest.first_name, @guest.first_name
      assert reservation.pending?
    end
  end

  test "should return error if guest not found" do
    assert_no_difference 'Reservation.count' do
      command = CreateReservation.new(parsed_payload.merge(guest: { id: 9999 })).call
      assert command.errors.present?
      assert_includes command.errors.full_messages, 'Guest not found'
    end
  end

  test "should return error if reservation invalid" do
    assert_no_difference 'Reservation.count' do
      Reservation.stubs(:create).raises(ActiveRecord::RecordInvalid.new(Reservation.new))
      command = CreateReservation.new(parsed_payload).call
      assert command.errors.present?
      assert_includes command.errors.full_messages.first, 'Validation failed'
    end
  end

  test "should handle unexpected errors gracefully" do
    assert_no_difference 'Reservation.count' do
      Reservation.stubs(:create).raises(StandardError.new("Unexpected error"))
      command = CreateReservation.new(parsed_payload).call
      assert command.errors.present?
      assert_includes command.errors.full_messages, 'Unexpected error'
    end
  end

  private

  def parsed_payload
    {
      guest: {
        id: @guest.id,
        email: @guest.email,
        first_name: @guest.first_name,
        last_name: @guest.last_name,
        phone_numbers: Array(@guest.phone_numbers)
      },
      reservation: {
        start_at: Date.today + 5.days,
        end_at: Date.today + 10.days,
        no_of_nights: 4,
        status: "pending",
        payout_amount: 4500.00,
        security_amount: 500.00,
        total_amount: 3800.00,
        currency: "AUD",
        details: {
          localized_description: "4 guests",
          number_of_guests: 4,
          number_of_adults: 3,
          number_of_children: 1,
          number_of_infants: 0
        }
      }
    }
  end
end