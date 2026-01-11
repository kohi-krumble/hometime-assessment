class Api::ReservationsController < AuthenticatedController
  wrap_parameters false

  def create
    parser = ReservationParserFactory.new(params).get_parser
    reservation_params = Reservation::PayloadParser.new(parser).parse
    command = CreateReservation.call(reservation_params)

    if command.success?
      render :show, status: :created, locals: { reservation: command.result }
    else
      render json: { errors: command.errors.full_messages }, status: :unprocessable_content
    end
  end
end
