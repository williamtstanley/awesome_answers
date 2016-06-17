# 300.times do
#     first_name = Faker::Name.first_name
#     last_name = Faker::Name.last_name
#     User.create first_name: first_name,
#                 last_name: last_name,
#                 email: "#{first_name}_#{last_name}@#{(first_name+last_name).split("").shuffle.join("")}.com"
# end
#
# puts Cowsay.say "Generated 300 users!"

300.times do
  q = Question.create title:      Faker::Company.bs,
                      body:       Faker::Hipster.paragraph,
                      view_count: rand(100)
  5.times { q.answers.create body: Faker::ChuckNorris.fact } if q.persisted?
end



["Sports", "Cats", "Technology", "News", "Gaming", "Parenting"].each do |cat|
    Category.create title: cat
end

# puts Cowsay.say "Generated 300 questions!"


