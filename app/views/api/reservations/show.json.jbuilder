json.reservation_id reservation.id
json.start_date reservation.start_at
json.end_date reservation.end_at
json.nights reservation.no_of_nights
json.status reservation.status

json.payout_amount reservation.payout_amount.to_s
json.security_amount reservation.security_amount.to_s
json.total_amount reservation.total_amount.to_s
json.currency reservation.currency

json.details do
  json.localized_description reservation.details.localized_description
  json.number_of_guests reservation.details.number_of_guests
  json.number_of_adults reservation.details.number_of_adults
  json.number_of_children reservation.details.number_of_children
  json.number_of_infants reservation.details.number_of_infants
end

json.guest do
  json.id reservation.guest.id
  json.first_name reservation.guest.first_name
  json.last_name reservation.guest.last_name
  json.email reservation.guest.email
  json.phone_numbers reservation.guest.phone_numbers.map(&:e164)
end

