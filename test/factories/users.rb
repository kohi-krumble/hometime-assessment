FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    first_name { "Test user" }
    last_name { "Last name" }
    phone_numbers { ["639123456789", "639987654321"] }

    trait :no_email do
      email { "" }
    end

    trait :invalid_email do
      email { "invalid email" }
    end
  end
end
