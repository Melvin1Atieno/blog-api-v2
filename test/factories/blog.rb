FactoryBot.define do
  factory :blog do
    user
    title {"first blog"}
    body{"This is the first blog post"}

    factory :blog_with_comment do
      transient do
        comments_count { 5 }
      end
      after(:create) do |blog, evaluator|
        create_list(:comment, evaluator.comments_count, blog: blog)
      end
    end
  end
end