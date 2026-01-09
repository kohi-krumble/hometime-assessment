class User < ApplicationRecord
  validates_presence_of :first_name
  validates :email, presence: true, uniqueness: true,
            format: { with: Rails.application.config.email_regex }
end
