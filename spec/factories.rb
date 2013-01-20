FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    email_confirmation "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end