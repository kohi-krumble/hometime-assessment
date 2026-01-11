class Api::ReservationsController < AuthenticatedController
  wrap_parameters false

  def create
    reservation_params = Reservation::PayloadParser.new(parser.new(params)).parse

    render json: reservation_params, status: :created
  end

  private

  def parser
    return Reservation::PayloadV2 if params.key?(:reservation)
    return Reservation::PayloadV1
  end
end
