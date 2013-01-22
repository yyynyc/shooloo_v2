namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 email_confirmation: "example@railstutorial.org", 
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   email_confirmation: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      question = Faker::Lorem.sentence(5)
      answer = Faker::Lorem.sentence(1)
      grade = Faker::Lorem.sentence(1)
      users.each { |user| user.posts.create!(question: question, answer: answer, 
        grade: grade) }
    end
  end
end
