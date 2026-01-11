# frozen_string_literal: true

class Reservation::DetailsType < ActiveRecord::Type::Value
  def type
    :jsonb
  end

  def cast(value)
    return {} if value.blank?

    Reservation::Details.new(value)
  end

  # convert database value to a Ruby object
  def deserialize(value)
    if value.is_a?(String)
      decoded = begin
        ::ActiveSupport::JSON.decode(value)
      rescue StandardError
        nil
      end
      Reservation::Details.new(decoded)
    else
      super
    end
  end

  # convert Ruby object to a format suitable for database storage
  def serialize(value)
    case value
    when Reservation::Details
      ::ActiveSupport::JSON.encode(value)
    else
      super
    end
  end
end
