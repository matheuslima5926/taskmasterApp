FactoryBot.define do
  factory :user do
    email {"email@gmail.com"}
    password {"123456789"}
    password_confirmation {"123456789"}
  end
end
