FactoryGirl.define do
  factory :user do
    sequence(:screen_name)  { |n| "Person_#{n}" }
    sequence(:first_name)  { |n| "First #{n}" }
    sequence(:last_name)  { |n| "Last #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"} 
    sequence(:email_confirmation) { |n| "person_#{n}@example.com"}  
    password "foobar"
    password_confirmation "foobar"
    privacy "true"
    rules "true"
    grade "Tutor"
    avatar File.new(Rails.root + 'spec/support/math.jpg') 

    factory :admin do
      admin true
    end
  end

  factory :post do
    user
    question "Lorem ipsum"
    answer "blah blah"
    grade "5"
    category "sports"
    photo File.new(Rails.root + 'spec/support/math.jpg') 
  end

  factory :comment do
    commenter(:user)
    commented_post(:post)
    content "This is a good question"
    visible true    
  end
end