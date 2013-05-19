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
    question "Factory_created Question"
    answer "Fatory-created Answer"
    grade "8th grade"
    category "sports"
    photo File.new(Rails.root + 'spec/support/math.jpg') 
  end

  factory :comment do
    commenter(:user)
    commented_post(:post)
    content "This is a good question"
    visible true    
  end

  factory :operation do
    sequence(:name)  { |n| "operation ##{n}" }
    sequence(:position)  { |n| "First #{n}" }
  end

  factory :rating do
    rater(:user)
    rated_post(:post)
    answer_correctness "1"
    steps "1"
    grade_suitability "1"
    overall_rating true 
    operations { FactoryGirl.create_list(:operation, 9) }
  end
end