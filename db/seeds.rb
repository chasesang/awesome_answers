# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# 200.times do
#   Question.create({ title: Faker::Friends.character,
#                     body:  Faker::Friends.quote,
#                     view_count: rand(1000)
#                   })
# end
#
# questions = Question.all
#
# questions.each do |q|
#   rand(0..10).times do
#     q.answer.create({
#       body: Faker::RuPaul.quote
#
#       })
#     end
#   end
#
# answers_count = Answer.count
#
# puts Cowsay.say 'Created 200 questions', :cow
# puts Cowsay.say 'Created #{answers_count} answers'
Subject.create(
  [
    {name: 'Science'},
    {name: 'Metal'},
    {name: 'Bad Ass'},
    {name: 'Prose'},
    {name: 'Memes'},
    {name: 'Pop'}
]
)

subjects = Subject.all
20.times do
  User.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: '123',
                password_confirmation: '123'
    )
    puts "User created!"
  end

200.times do
  user = User.all.sample
  Question.create({ title: Faker::Hacker.say_something_smart,
                    body:  Faker::Hipster.paragraph,
                    view_count: rand(1000),
                    subject: subjects.sample,
                    user_id: user.id
                  })
end

questions = Question.all

questions.each do |q|
  rand(0..10).times do
  
    q.answers.create({
        body: Faker::Friends.quote,

      })
  end
end

answers_count = Answer.count



puts Cowsay.say 'Created 1000 questions ð®', :cow

puts Cowsay.say "Created #{answers_count} answers ð©", :ghostbusters
