require "test_helper"

class Api::ReservationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @payload_v1 = JSON.parse(file_fixture("reservation/payload-v1.json").read)
    @payload_v2 = JSON.parse(file_fixture("reservation/payload-v2.json").read)
    @headers = {
      "Authorization" => "Bearer #{JwtService.encode(expires_at: 24.hours.from_now)}"
    }
  end
  
  test "should create reservation with valid payload using parser v1" do
    guest = create(:guest, id: 1)

    post api_reservations_url, params: @payload_v1, headers: @headers, as: :json
    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal json_response["reservation_id"], Reservation.last.id
    assert_equal json_response.dig("guest", "id"), guest.id
  end

  test "should create reservation with valid payload using parser v2" do
    guest = create(:guest, id: 1)

    post api_reservations_url, params: @payload_v2, headers: @headers, as: :json
    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal json_response["reservation_id"], Reservation.last.id
    assert_equal json_response.dig("guest", "id"), guest.id
  end

  test "should not create reservation with invalid guest" do
    payload = @payload_v1.deep_merge("guest" => { "id" => 9999 })

    post api_reservations_url, params: payload, headers: @headers, as: :json
    assert_response :unprocessable_content

    json_response = JSON.parse(response.body)
    assert_includes json_response["errors"], "Guest not found"
  end

  test "should not create reservation with invalid payload" do
    create(:guest, id: 1)
    payload = JSON.parse(file_fixture("reservation/invalid-reservation-payload-v1.json").read)

    post api_reservations_url, params: payload, headers: @headers, as: :json
    assert_response :unprocessable_content

    json_response = JSON.parse(response.body)
    assert_includes json_response["errors"], "Reservation Start at must be greater than #{Date.today.strftime('%Y-%m-%d')}"
  end

  test "should match reservation details" do
    create(:guest, id: 1)
    post api_reservations_url, params: @payload_v2, headers: @headers, as: :json
    assert_response :created

    reservation = Reservation.last
    json_response = JSON.parse(response.body)
    assert_equal json_response["reservation_id"], reservation.id
    assert_equal json_response["start_date"], reservation.start_at.as_json
    assert_equal json_response["end_date"], reservation.end_at.as_json
  end

  test "should return unauthorized error when no authorization token provided" do
    post api_reservations_url, params: @payload_v1, headers: {}, as: :json
    assert_response :unauthorized
  end

  test "should return unauthorized error when wrong authorization token is provided" do
    post api_reservations_url, params: @payload_v1, headers: { "Authorization" => "Bearer #{SecureRandom.base64}" }, as: :json
    assert_response :unauthorized
  end
end
