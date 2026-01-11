class ReservationParserFactory

  def initialize(payload)
    @payload = payload
  end

  def get_parser(version: nil)
    return parser_by_version(version) if version.present?

    # TODO: CHECK request.domain
    # ex. request.domain == "airbnb.co.uk" 
    return parser_v2 if @payload.key?(:reservation)
    return parser_v1
  end

  private

  def parser_by_version(version)
    case version
    when :v1 then parser_v1
    when :v2 then parser_v2
    else raise "Unsupported parser version: #{version}"
    end
  end

  def parser_v1
    @parser_v1 ||= Reservation::PayloadV1.new(@payload)
  end

  def parser_v2
    @parser_v2 ||= Reservation::PayloadV2.new(@payload)
  end
end