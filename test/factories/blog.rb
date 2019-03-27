FactoryBot.define do
  factory :blog do
    user
    title { random_word }
    body{"This is the first blog post. It should be atleast 50
          words. This is the story of how I got myself typing
          atleast fifty words. Just like that. I hope this does it
          because I am not about t start counting these characters"}

    factory :blog_with_comments do
      transient do
        comments_count { 5 }
      end
      after(:create) do |blog, evaluator|
        create_list(:comment, evaluator.comments_count, blog: blog)
      end
    end
  end
end

def random_word
  ('a'..'z').to_a.shuffle.join
end