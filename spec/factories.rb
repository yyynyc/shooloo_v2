FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"} 
    sequence(:email_confirmation) { |n| "person_#{n}@example.com"}  
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :post do
    question "Lorem ipsum"
    answer "blah blah"
    grade "5"
    user
  end
end