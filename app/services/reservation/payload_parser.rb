class Reservation::PayloadParser

  def initialize(parser)
    @parser = parser
  end

  def parse
    {
      guest: parse_guest,
      reservation: parse_reservation
    }
  end

  private

  def parse_guest
    {
      id: @parser.guest_id,
      email: @parser.guest_email,
      first_name: @parser.guest_first_name,
      last_name: @parser.guest_last_name,
      phone_numbers: Array(@parser.guest_phone_numbers)
    }
  end

  def parse_reservation
    {
      start_at: @parser.start_at,
      end_at: @parser.end_at,
      no_of_nights: @parser.no_of_nights,
      status: @parser.status,
      payout_amount: @parser.payout_amount,
      security_amount: @parser.security_amount,
      total_amount: @parser.total_amount,
      currency: @parser.currency,
      details: {
        localized_description: @parser.localized_description,
        number_of_guests: @parser.number_of_guests,
        number_of_adults: @parser.number_of_adults,
        number_of_children: @parser.number_of_children,
        number_of_infants: @parser.number_of_infants
      }
    }
  end
end