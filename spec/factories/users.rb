FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence :email do |n| 
      Faker::Internet.email + "#{n}"
    end 
    password_digest Faker::Internet.password

    factory :user_with_posts do
      transient do
        posts_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
