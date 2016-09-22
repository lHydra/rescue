FactoryGirl.define do
  factory :post do
    author 
    title Faker::Lorem.word
    text Faker::Lorem.sentence
    user
  end
end
