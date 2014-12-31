# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.where(user_name: "Johnny Cash").first_or_create!
user2 = User.where(user_name: "Michael Jordan").first_or_create!
user3 = User.where(user_name: "Michael Jackson").first_or_create!

p1 = user1.authored_polls.create!(title: "Best TA")

  q1 = p1.questions.create!(text: "Who is it?")

    a1 = q1.answer_choices.create!(text: "Shawna")
    a2 = q1.answer_choices.create!(text: "David")
    a3 = q1.answer_choices.create!(text: "Jeff")
    a4 = q1.answer_choices.create!(text: "CJ")

      a1.responses.create!(user_id: user2.id)
      a3.responses.create!(user_id: user3.id)

  q2 = p1.questions.create!(text: "Grade?")

    g1 = q2.answer_choices.create!(text: "A")
    g2 = q2.answer_choices.create!(text: "B")
    g3 = q2.answer_choices.create!(text: "C")

      g1.responses.create!(user_id: user2.id)
