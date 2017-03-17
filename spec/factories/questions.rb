FactoryGirl.define do
  sequence :title do |n|
    "MyString#{n}"
  end
  
  factory :question do
    title
    body "MyText"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
