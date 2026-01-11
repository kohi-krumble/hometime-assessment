FactoryBot.define do
  factory :guest, class: "Guest", parent: :user do
    email { "guest@example.com" }
    first_name { "Guest user" }
    user_type { 'guest' }
  end
end
