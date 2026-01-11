class CreateReservation
  prepend SimpleCommand

  def initialize(params)
    @params = params
    @guest = Guest.find_by(id: @params.dig(:guest, :id))
  end

  def call
    guest = Guest.find_by(id: @params.dig(:guest, :id))
    return errors.add(:guest, 'not found') if guest.blank?

    reservation = Reservation.create(user_id: guest.id, **@params[:reservation])
    return errors.add(:reservation, reservation.errors.full_messages.to_sentence) if !reservation.persisted?

    return reservation
  rescue StandardError => e
    errors.add :base, e.message
  end
end