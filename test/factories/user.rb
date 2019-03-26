FactoryBot.define do
  factory :user do
    sequence(:id){ |n| n}
    username {"John" + random_word}
    email {"#{username}@example.com"}
    password{"mysecretpass"}
  
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

def random_word
  ('a'..'z').to_a.shuffle.join
end