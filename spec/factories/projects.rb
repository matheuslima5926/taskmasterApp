FactoryBot.define do
  factory :project do
    name { "Novo projeto" }
    user
    done { false }
    start_date { "2021-03-12 20:04:52" }
    finished_date { "2021-03-12 20:04:52" }
  end
end
