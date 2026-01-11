class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,}\z/i
  
  def validate_each(record, attribute, value)
    return if value =~ EMAIL_REGEX

    record.errors.add(attribute, (options[:message] || "is invalid"))
  end
end