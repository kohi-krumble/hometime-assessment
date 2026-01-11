class Api::ReservationsController < AuthenticatedController
  wrap_parameters false

  def create
    reservation_params = Reservation::PayloadParser.new(parser.new(params)).parse
    command = CreateReservation.call(reservation_params)

    if command.success?
      render :show, status: :created, locals: { reservation: command.result }
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def parser
    return Reservation::PayloadV2 if params.key?(:reservation)
    return Reservation::PayloadV1
  end
end
