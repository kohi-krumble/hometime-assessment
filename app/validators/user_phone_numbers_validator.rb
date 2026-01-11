class UserPhoneNumbersValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, (options[:message] || "should have at least one phone number"))
      return
    end

    value.each do |phone_number|
      if !Phonelib.valid?(phone_number)
        record.errors.add(attribute, (options[:message] || "#{phone_number} is not valid"))
      end
    end
  end
end