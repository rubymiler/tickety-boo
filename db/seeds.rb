10.times do
  User.create(email: Faker::Internet.email, password: 'remember')
end

puts '10 users created!'

User.all.each do |user|
  10.times do
    user.submitted_tickets.create(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      public: [true, false].sample
    )
  end
end

puts '10 tickets for each submitter created!'
