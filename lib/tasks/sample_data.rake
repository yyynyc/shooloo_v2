namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
  end
end

  def make_users 
    admin = User.create!(first_name: "Example",
                last_name: "User",
                grade: "5th grade",
                screen_name: "Faker_Test",
                email: "example@railstutorial.org",
                email_confirmation: "example@railstutorial.org", 
                password: "foobar",
                password_confirmation: "foobar", 
                privacy: true,
                rules: true,                
                avatar: File.new(Rails.root + 'app/assets/images/rails.png'))
    admin.toggle!(:admin)

    99.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      grade = "4th grade"
      screen_name = "test_user_#{n+1}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      privacy = true
      rules = true
      avatar = File.new(Rails.root + 'app/assets/images/rails.png')
      User.create!(first_name: first_name,
                   last_name: last_name,
                   grade: grade,
                   screen_name: screen_name,
                   email: email,
                   email_confirmation: email,
                   password: password,
                   password_confirmation: password,
                   privacy: privacy,
                   rules: rules,
                   avatar: avatar)
    end
  end

  def make_posts
    users = User.all(limit: 6)
    50.times do
      question = Faker::Lorem.sentence(5)
      answer = Faker::Lorem.sentence(1)
      grade = "5th grade"
      category = "books"
      photo = File.new(Rails.root + 'spec/support/math.jpg')
      users.each { |user| user.posts.create!(question: question, answer: answer, 
        grade: grade, category: category, photo: photo) }
    end
  end

  def make_relationships
    users = User.all
    user  = users.first
    followed_users = users[2..50]
    followers      = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end

  def make_ratings
    users = User.all
    user = users.first
  end
