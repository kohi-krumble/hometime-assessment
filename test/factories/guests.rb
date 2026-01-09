FactoryBot.define do
  factory :guest, parent: :user do
    email { "guest@example.com" }
    first_name { "Guest user" }
  end
end
