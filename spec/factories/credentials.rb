FactoryBot.define do
  factory :credential do
    username 'UserName'
    apikey 'ApiKey'
    association :user
  end
end
