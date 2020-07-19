20.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'remember')
end

User.last.manager!

User.where(id: 14..19).each(&:agent!)

puts '20 users created!'

30.times do
  Topic.create(name: Faker::ProgrammingLanguage.name)
end

puts '30 topics created!'

User.member.each do |user|
  10.times do
    user.submitted_tickets.create(
      title: Faker::Lorem.sentence,
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nisl suscipit adipiscing bibendum est ultricies integer quis auctor. Id aliquet lectus proin nibh nisl condimentum. Tortor dignissim convallis aenean et tortor at risus. Nisl rhoncus mattis rhoncus urna neque. Id aliquet lectus proin nibh nisl condimentum id venenatis. Quam quisque id diam vel quam elementum pulvinar etiam. In metus vulputate eu scelerisque felis. Sagittis orci a scelerisque purus semper eget. Maecenas ultricies mi eget mauris pharetra et ultrices neque ornare. Scelerisque in dictum non consectetur a erat. Cras ornare arcu dui vivamus arcu felis bibendum ut. Quam quisque id diam vel quam elementum pulvinar etiam non. Sed id semper risus in hendrerit gravida rutrum quisque non. Porttitor lacus luctus accumsan tortor posuere. Sit amet dictum sit amet justo donec enim diam. Id diam vel quam elementum. Viverra nibh cras pulvinar mattis nunc sed blandit libero. Enim nulla aliquet porttitor lacus luctus accumsan tortor.',
      topics: Topic.all.sample(3)
    )
  end
end

puts '10 tickets for each submitter created!'
