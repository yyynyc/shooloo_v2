FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"} 
    sequence(:email_confirmation) { |n| "person_#{n}@example.com"}  
    password "foobar"
    password_confirmation "foobar"
    avatar File.new(Rails.root + 'spec/support/math.jpg') 

    factory :admin do
      admin true
    end
  end

  factory :post do
    question "Lorem ipsum"
    answer "blah blah"
    grade "5"
    user
    photo File.new(Rails.root + 'spec/support/math.jpg') 
  end
end