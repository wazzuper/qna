FactoryGirl.define do
  factory :vote do
    rating 1
    user
    association :votable
  end
end