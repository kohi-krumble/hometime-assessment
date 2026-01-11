# frozen_string_literal: true

class User::PhoneNumbersType < ActiveRecord::Type::Value
  def type
    :array
  end

  def cast(value)
    return [] if value.blank?

    value.map do |phone_number|
      Phonelib.parse(phone_number)
    end
  end

  def deserialize(value)
    if value.is_a?(String)
      decoded = begin
        ::ActiveSupport::JSON.decode(value)
      rescue StandardError
        nil
      end
      decoded.map do |phone_number|
        Phonelib.parse(phone_number)
      end
    else
      super
    end
  end

  # convert Ruby object to a format suitable for database storage
  def serialize(value)
    case value
    when Array
      phone_numbers = value.map(&:original)
      ::ActiveSupport::JSON.encode(phone_numbers)
    else
      super
    end
  end
end
