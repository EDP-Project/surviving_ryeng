namespace :db do
  desc "Populate database with course data"
  task add_courses: :environment do

    User.create!(first_name: 'Steve',
                   last_name: 'Singh',
                   username: 'Kastralliss',
                   about_me: "Computer Engineering student and aspiring Rails developer. Creator of this web application.",
                   email: 'kastrallis@gmail.com',
                   admin: true,
                   password: 'steve123',
                   password_confirmation: 'steve123')

    50.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      username = ('a'..'z').to_a.shuffle[0,10].join
      email = "dummy-#{n}@railstutorial.org"
      password  = "password"
      about_me = Faker::Lorem.sentences(5).join(' ')

      User.create!(first_name: first_name,
                   last_name: last_name,
                   username: username,
                   about_me: about_me,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    #Create a single admin feed
    AdminFeed.create!

    #Create friendships between me and 20 other users
    20.times do |n|
      Friendship.create!(user_id: 1, friend_id: n+2)
      Friendship.create!(user_id: n+2, friend_id: 1)
    end

    #Create friendship requests sent from me to 15 other users
    15.times do |n|
      FriendRequest.create!(user_id: 1, receiver_id: n+22)      
    end

    #Create friendship requests received from me to 15 other users
    15.times do |n|
      FriendRequest.create!(user_id: n+37, receiver_id: 1)      
    end

    #Create a fake argument
    @arg = User.first.arguments.build(subject: 'Test Argument', content: Faker::Lorem.sentences(10).join(' '), answered: true)

    #Add fake solutions
    20.times do 
      @arg.replies.build(user_id: rand(1..40),header: Faker::Lorem.sentence, body: Faker::Lorem.sentences(rand(2..15)).join(' ') )
    end

    #Select an answer at random and save
    @arg.answer = @arg.replies[rand(0..19)]
    @arg.save

  end
end

def add(code, desc)
  Course.create!(course_code: code, description: desc)
end