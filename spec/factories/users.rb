FactoryBot.define do
  factory :user do
    provider 'provider'
    uid 'randomUid'
    first_name 'Grzegoz'
    last_name 'Kovalsky'
    email 'grzegorz@kovalsky@test.test'
  end
end
