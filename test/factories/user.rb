FactoryBot.define do
  factory :user do
    username {"John"}
    email {"#{username}@example.com"}
    password_digest {"password"}
  
    factory :user_with_blogs do
      transient do
        blogs_count { 5 }
      end


      after(:create) do |user, evaluator|
          create_list(:blog, evaluator.blogs_count, user: user)
      end
    end
  end
end